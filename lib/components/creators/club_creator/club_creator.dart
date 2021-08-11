import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/creators/club_creator/club_creator_info.dart';
import 'package:spotmefitness_ui/components/creators/club_creator/club_creator_media.dart';
import 'package:spotmefitness_ui/components/creators/club_creator/club_creator_members.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class ClubCreatorPage extends StatefulWidget {
  final Club? club;
  const ClubCreatorPage({
    Key? key,
    this.club,
  }) : super(key: key);

  @override
  _ClubCreatorPageState createState() => _ClubCreatorPageState();
}

class _ClubCreatorPageState extends State<ClubCreatorPage> {
  /// Pre-create data fields.
  /// User must add these (only name is required) and then save.
  /// This creates a new club in the DB and returns it.
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  /// Post-create data. We go straight here in the case of editing a club.
  Club? _activeClub;
  Map<String, dynamic> _activeClubBackup = {};

  PageController _pageController = PageController();
  int _activePageIndex = 0;

  /// Doing something over the network - replaces tab sliding select and 'done' buttons with loading indicators.
  bool _savingToDB = false;
  bool _uploadingMedia = false;
  late bool _isCreate;

  @override
  void initState() {
    super.initState();

    _isCreate = widget.club == null;

    if (!_isCreate) {
      _activeClub = Club.fromJson(widget.club!.toJson());
    }

    if (_activeClub == null) {
      _initPreCreateDataFields();
    } else {
      /// Create initial backup data.
      _activeClubBackup = _activeClub!.toJson();
    }
  }

  void _initPreCreateDataFields() {
    _nameController.addListener(() {
      setState(() {});
    });
    _descriptionController.addListener(() {
      setState(() {});
    });
    _locationController.addListener(() {
      setState(() {});
    });
  }

  void _updatePageIndex(int i) {
    Utils.hideKeyboard(context);
    _pageController.jumpToPage(i);
    setState(() => _activePageIndex = i);
  }

  Future<void> _createClub() async {
    setState(() => _savingToDB = true);

    final variables = CreateClubArguments(
        data: CreateClubInput(
            name: _nameController.text,
            description: _descriptionController.text,
            location: _locationController.text));

    final result = await context.graphQLStore
        .create<CreateClub$Mutation, CreateClubArguments>(
            mutation: CreateClubMutation(variables: variables),
            addRefToQueries: [GQLOpNames.userClubsQuery]);

    setState(() => _savingToDB = false);

    if (result.hasErrors || result.data == null) {
      context.showErrorAlert(
          'Sorry there was a problem, the Club was not created.');
    } else {
      setState(() {
        _activeClub = result.data!.createClub;
      });

      context.showToast(message: 'Club created!', toastType: ToastType.success);

      _activeClubBackup = _activeClub!.toJson();
    }
  }

  void _onMediaUploadComplete(Map<String, dynamic> data) {
    setState(() {
      _uploadingMedia = false;
    });

    _updateClub(data);
  }

  void _updateClub(Map<String, dynamic> data) {
    if (_activeClub == null) {
      throw Exception(
          'ClubCreatorPage._updateClub: [_activeClub] has not been initialized.');
    }

    setState(() {
      _activeClub = Club.fromJson({
        ..._activeClub!.toJson(),
        ...data,
      });
    });

    /// Send new data to DB. Pass just the updated data via [customVariablesMap]
    _saveUpdateToDB(data);
  }

  Future<void> _saveUpdateToDB(Map<String, dynamic> data) async {
    if (_activeClub == null) {
      throw Exception(
          'ClubCreatorPage._saveUpdateToDB: [_activeClub] has not been initialized.');
    }

    setState(() => _savingToDB = true);

    final variables = UpdateClubArguments(
        data: UpdateClubInput(
      id: _activeClub!.id,
    ));

    final result = await context.graphQLStore
        .mutate<UpdateClub$Mutation, UpdateClubArguments>(
      mutation: UpdateClubMutation(variables: variables),
      customVariablesMap: {
        'data': {'id': _activeClub!.id, ...data}
      },
      broadcastQueryIds: [
        UserClubsQuery().operationName,
        GQLVarParamKeys.clubByIdQuery(_activeClub!.id)
      ],
    );

    setState(() => _savingToDB = false);

    if (result.hasErrors || result.data == null) {
      context.showErrorAlert(
          'Sorry there was a problem, the Club was not updated.');

      /// Roll back the changes.
      setState(() {
        _activeClub = Club.fromJson(_activeClubBackup);
      });
    } else {
      setState(() {
        _activeClub = result.data!.updateClub;
      });

      /// Update the backup data.
      _activeClubBackup = _activeClub!.toJson();
    }
  }

  Future<void> _deleteClubInviteToken(ClubInviteToken token) async {
    if (_activeClub == null) {
      throw Exception(
          'ClubCreatorPage._saveUpdateToDB: [_activeClub] has not been initialized.');
    }

    setState(() => _savingToDB = true);

    final variables = DeleteClubInviteTokenByIdArguments(id: token.id);

    final result = await context.graphQLStore.delete<
            DeleteClubInviteTokenById$Mutation,
            DeleteClubInviteTokenByIdArguments>(
        mutation: DeleteClubInviteTokenByIdMutation(variables: variables),
        objectId: token.id,
        typename: kClubInviteTokenTypeName,

        /// TODO: Assumes that we want to normalize these ClubInviteToken objects. Need to asses.
        removeAllRefsToId: true);

    setState(() => _savingToDB = false);

    if (result.hasErrors ||
        result.data?.deleteClubInviteTokenById != token.id) {
      context.showErrorAlert(
          'Sorry there was a problem, the invite link was not deleted.');
    } else {
      setState(() {
        _activeClub!.clubInviteTokens =
            _activeClub!.clubInviteTokens.toggleItem(token);
      });

      /// Update the backup data.
      _activeClubBackup = _activeClub!.toJson();
    }
  }

  /// Will not save anything.
  void _close() {
    context.pop();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: BorderlessNavBar(
        withoutLeading: true,
        middle: Row(
          children: [
            NavBarLargeTitle(_isCreate ? 'Create Club' : 'Edit Club'),
          ],
        ),
        trailing: _savingToDB
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  NavBarLoadingDots(),
                ],
              )
            : _activeClub == null
                ? NavBarCancelButton(_close)
                : NavBarTextButton(_close, 'Done'),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: AnimatedSwitcher(
              duration: kStandardAnimationDuration,
              child: _uploadingMedia
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyText('Uploading media'),
                        SizedBox(width: 6),
                        NavBarLoadingDots()
                      ],
                    )
                  : _activeClub == null
                      ? PrimaryButton(
                          text: 'Create Club',
                          onPressed: _createClub,
                          prefix: Icon(
                            CupertinoIcons.add_circled,
                            color: context.theme.background,
                          ),
                          disabled: _nameController.text.length < 3,
                          loading: _savingToDB,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: SlidingSelect<int>(
                                value: _activePageIndex,
                                updateValue: _updatePageIndex,
                                children: {
                                  0: MyText('Info'),
                                  1: MyText('Media'),
                                  2: MyText('Members'),
                                }),
                          ),
                        ),
            ),
          ),
          _activeClub == null
              ? _PreCreateInputUI(
                  descriptionController: _descriptionController,
                  locationController: _locationController,
                  nameController: _nameController,
                )
              : Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ClubCreatorInfo(
                        club: _activeClub!,
                        updateClub: _updateClub,
                      ),
                      ClubCreatorMedia(
                        coverImageUri: _activeClub?.coverImageUri,
                        onImageUploaded: (imageUri) =>
                            _onMediaUploadComplete({'coverImageUri': imageUri}),
                        removeImage: (_) =>
                            _onMediaUploadComplete({'coverImageUri': null}),
                        introVideoUri: _activeClub?.introVideoUri,
                        introVideoThumbUri: _activeClub?.introVideoThumbUri,
                        onVideoUploaded: (videoUri, thumbUri) =>
                            _onMediaUploadComplete({
                          'introVideoUri': videoUri,
                          'introVideoThumbUri': thumbUri
                        }),
                        removeVideo: () => _onMediaUploadComplete({
                          'introVideoUri': null,
                          'introVideoThumbUri': null
                        }),
                        introAudioUri: _activeClub?.introAudioUri,
                        onAudioUploaded: (audioUri) =>
                            _onMediaUploadComplete({'introAudioUri': audioUri}),
                        removeAudio: () =>
                            _onMediaUploadComplete({'introAudioUri': null}),
                        onMediaUploadStart: () =>
                            setState(() => _uploadingMedia = true),
                      ),
                      ClubCreatorMembers(
                        club: _activeClub!,
                        deleteClubInviteToken: (token) =>
                            _deleteClubInviteToken(token),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

/// Displays in the case the a user is creating a brand new club.
/// They enter some basic info about it and then click save.
/// Once saved and data is back from the DB then UI reverts to the standard UI.
class _PreCreateInputUI extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController locationController;

  const _PreCreateInputUI({
    Key? key,
    required this.nameController,
    required this.descriptionController,
    required this.locationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        MyTextFormFieldRow(
          autofocus: true,
          backgroundColor: context.theme.cardBackground,
          controller: nameController,
          placeholder: 'Name (required)',
          keyboardType: TextInputType.text,
          validator: () =>
              nameController.text.length > 2 && nameController.text.length < 21,
          validationMessage: 'Min 3, max 20 characters',
        ),
        MyTextAreaFormFieldRow(
            placeholder: 'Description (optional)',
            backgroundColor: context.theme.cardBackground,
            keyboardType: TextInputType.text,
            controller: descriptionController),
        MyTextAreaFormFieldRow(
            placeholder: 'Location (optional)',
            backgroundColor: context.theme.cardBackground,
            keyboardType: TextInputType.text,
            controller: locationController),
      ],
    );
  }
}

class _InvitesPage extends StatelessWidget {
  const _InvitesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
