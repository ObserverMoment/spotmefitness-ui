import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/creators/club_creator/club_creator_info.dart';
import 'package:spotmefitness_ui/components/creators/club_creator/club_creator_media.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/audio/audio_uploader.dart';
import 'package:spotmefitness_ui/components/media/images/cover_image_uploader.dart';
import 'package:spotmefitness_ui/components/media/images/image_uploader.dart';
import 'package:spotmefitness_ui/components/media/images/user_avatar_uploader.dart';
import 'package:spotmefitness_ui/components/media/video/video_uploader.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/utils.dart';

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
  /// Page 1 data fields.
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;

  /// Page 2 Data Fields.
  late String? _coverImageUri;
  late String? _introVideoUri;
  late String? _introVideoThumbUri;
  late String? _introAudioUri;

  PageController _pageController = PageController();
  int _activePageIndex = 0;

  /// Doing something over the network - replaces tab sliding select and 'done' buttons with loading indicators.
  bool _loading = false;
  late bool _isCreate;

  /// When creating the user must enter the first page details and hit save.
  /// This will create the club in the DB and they will then be able to access all pages of the create / edit UI.
  late bool _clubCreated;
  String? _activeClubId;

  @override
  void initState() {
    _isCreate = widget.club == null;
    _clubCreated = !_isCreate;
    _activeClubId = widget.club?.id;
    _initPageOneDataFields();
    _initPageTwoDataFields();
    super.initState();
  }

  void _initPageOneDataFields() {
    _coverImageUri = widget.club?.coverImageUri;
    _nameController = TextEditingController(text: widget.club?.name);
    _descriptionController =
        TextEditingController(text: widget.club?.description);
    _locationController = TextEditingController(text: widget.club?.location);

    _nameController.addListener(() {
      setState(() {});
      if (_clubCreated) {
        _updateClub({'name': _nameController.text});
      }
    });
    _descriptionController.addListener(() {
      setState(() {});
      if (_clubCreated) {
        _updateClub({'description': _descriptionController.text});
      }
    });
    _locationController.addListener(() {
      setState(() {});
      if (_clubCreated) {
        _updateClub({'location': _locationController.text});
      }
    });
  }

  void _initPageTwoDataFields() {
    _coverImageUri = widget.club?.coverImageUri;
    _introVideoUri = widget.club?.introVideoUri;
    _introVideoThumbUri = widget.club?.introVideoThumbUri;
    _introAudioUri = widget.club?.introAudioUri;
  }

  void _updatePageIndex(int i) {
    Utils.hideKeyboard(context);
    _pageController.toPage(i);
    setState(() => _activePageIndex = i);
  }

  Future<void> _createClub() async {
    setState(() => _loading = true);

    final variables = CreateClubArguments(
        data: CreateClubInput(
            name: _nameController.text,
            description: _descriptionController.text,
            location: _locationController.text));

    final result = await context.graphQLStore
        .create<CreateClub$Mutation, CreateClubArguments>(
            mutation: CreateClubMutation(variables: variables),
            addRefToQueries: [GQLOpNames.userClubsQuery]);

    setState(() => _loading = false);

    if (result.hasErrors || result.data == null) {
      context.showErrorAlert(
          'Sorry there was a problem, the Club was not created.');
    } else {
      setState(() {
        _activeClubId = result.data!.createClub.id;
        _clubCreated = true;
      });
      context.showToast(message: 'Club created!', toastType: ToastType.success);
    }
  }

  void _handleImageUpdate(String? coverImageUri) {
    setState(() {
      _coverImageUri = coverImageUri;
    });
    _updateClub({'coverImageUri': _coverImageUri});
  }

  void _handleVideoUpdate(String? videoUri, String? thumbUri) {
    setState(() {
      _introVideoUri = videoUri;
      _introVideoThumbUri = thumbUri;
    });
    _updateClub({
      'introVideoUri': _introVideoUri,
      'introVideoThumbUri': _introVideoThumbUri
    });
  }

  void _handleAudioUpdate(String? uri) {
    setState(() {
      _introAudioUri = uri;
    });
    _updateClub({'introAudioUri': _introAudioUri});
  }

  Future<void> _updateClub(Map<String, dynamic> data) async {
    setState(() => _loading = true);

    final variables = UpdateClubArguments(
        data: UpdateClubInput(
      id: widget.club!.id,
    ));

    final result = await context.graphQLStore
        .mutate<UpdateClub$Mutation, UpdateClubArguments>(
      mutation: UpdateClubMutation(variables: variables),
      customVariablesMap: {
        'data': {'id': _activeClubId, ...data}
      },
      broadcastQueryIds: [
        UserClubsQuery().operationName,
        GQLVarParamKeys.clubByIdQuery(widget.club!.id)
      ],
    );

    setState(() => _loading = false);

    if (result.hasErrors || result.data == null) {
      context.showErrorAlert(
          'Sorry there was a problem, the Club was not updated.');
    }
  }

  /// Will not save anything is [showPreCreateUI] is true.
  void _close() {
    context.pop();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Before anything has been saved to the DB the user should enter at least a name (optional description and location) and then save it. Once this is done the UI changes to display an 'editing' UI which also opens up the media and members tabs to them.
    final showPreCreateUI = _isCreate && !_clubCreated;

    return MyPageScaffold(
      navigationBar: BorderlessNavBar(
        withoutLeading: true,
        middle: Row(
          children: [
            NavBarLargeTitle(_isCreate ? 'Create Club' : 'Edit Club'),
          ],
        ),
        trailing: _loading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  NavBarLoadingDots(),
                ],
              )
            : showPreCreateUI
                ? NavBarCancelButton(_close)
                : NavBarTextButton(_close, 'Done'),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: AnimatedSwitcher(
              duration: kStandardAnimationDuration,
              child: showPreCreateUI
                  ? PrimaryButton(
                      text: 'Create Club',
                      onPressed: _createClub,
                      prefix: Icon(
                        CupertinoIcons.add_circled,
                        color: context.theme.background,
                      ),
                      disabled: _nameController.text.length < 3,
                      loading: _loading,
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
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ClubCreatorInfo(
                  descriptionController: _descriptionController,
                  locationController: _locationController,
                  nameController: _nameController,
                  showPreCreateUI: showPreCreateUI,
                ),
                ClubCreatorMedia(
                  coverImageUri: _coverImageUri,
                  onImageUploaded: _handleImageUpdate,
                  removeImage: (_) => _handleImageUpdate(null),
                  introVideoUri: _introVideoUri,
                  introVideoThumbUri: _introVideoThumbUri,
                  onVideoUploaded: _handleVideoUpdate,
                  removeVideo: () => _handleVideoUpdate(null, null),
                  introAudioUri: _introAudioUri,
                  onAudioUploaded: _handleAudioUpdate,
                  removeAudio: () => _handleAudioUpdate(null),
                  onMediaUploadStart: () => setState(() => _loading = true),
                ),
                _InvitesPage(),
              ],
            ),
          ),
        ],
      ),
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
