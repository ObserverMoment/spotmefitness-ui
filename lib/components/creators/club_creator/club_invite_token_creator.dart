import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/number_input.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/default_object_factory.dart';
import 'package:spotmefitness_ui/services/utils.dart';

/// Creates the invite token and then passes it back up to parent so that it can be added to the club and the store + UI (for the club) can be updated.
class ClubInviteTokenCreator extends StatefulWidget {
  /// When creating [token] should be null but the parent [club] is required.
  /// When editing just the [token] is required. (updates just require the object ID)
  final ClubInviteToken? token;
  final Club? club;
  final void Function(ClubInviteToken token)? onUpdateComplete;
  const ClubInviteTokenCreator({
    Key? key,
    this.token,
    this.club,
    this.onUpdateComplete,
  })  : assert(token != null || club != null),
        super(key: key);

  @override
  _ClubInviteTokenCreatorState createState() => _ClubInviteTokenCreatorState();
}

class _ClubInviteTokenCreatorState extends State<ClubInviteTokenCreator> {
  late bool _isCreate;
  bool _savingToDB = false;
  late ClubInviteToken _activeToken;
  late bool _enableInviteLimit;
  final _nameController = TextEditingController();
  final _inviteLimitController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _isCreate = widget.token == null;

    if (!_isCreate) {
      _activeToken = ClubInviteToken.fromJson(widget.token!.toJson());
      _nameController.text = _activeToken.name;
      _inviteLimitController.text = _activeToken.inviteLimit.toString();
    } else {
      _activeToken = DefaultObjectfactory.defaultClubInviteToken();
    }

    _inviteLimitController.text = _activeToken.inviteLimit.toString();
    _enableInviteLimit = _activeToken.inviteLimit != 0;

    _nameController.addListener(() {
      setState(() {
        _activeToken.name = _nameController.text;
      });
    });

    _inviteLimitController.addListener(() {
      if (Utils.textNotNull(_inviteLimitController.text)) {
        setState(() {
          _activeToken.inviteLimit = int.parse(_inviteLimitController.text);
        });
      } else {
        _inviteLimitController.text = 0.toString();
      }
    });
  }

  Future<void> _handleCreate() async {
    if (widget.club == null) {
      throw Exception(
          'ClubInviteTokenCreator._handleCreate: Cannot create a ClubInviteToken without the parent Club');
    }
    setState(() => _savingToDB = true);

    final variables = CreateClubInviteTokenArguments(
        data: CreateClubInviteTokenInput(
            name: _activeToken.name,
            club: ConnectRelationInput(id: widget.club!.id),
            inviteLimit: _enableInviteLimit ? _activeToken.inviteLimit : 0));

    final result = await context.graphQLStore
        .create<CreateClubInviteToken$Mutation, CreateClubInviteTokenArguments>(
            mutation: CreateClubInviteTokenMutation(variables: variables));

    setState(() => _savingToDB = false);

    if (result.hasErrors || result.data == null) {
      context.showErrorAlert(
          'Sorry there was a problem, the invite link was not created.');
    } else {
      if (widget.onUpdateComplete != null) {
        widget.onUpdateComplete!(result.data!.createClubInviteToken);
      }

      context.pop();
    }
  }

  Future<void> _handleUpdate() async {
    setState(() => _savingToDB = true);

    final variables = UpdateClubInviteTokenArguments(
        data: UpdateClubInviteTokenInput(
            name: _activeToken.name,
            inviteLimit: _enableInviteLimit ? _activeToken.inviteLimit : 0,
            id: _activeToken.id));

    final result = await context.graphQLStore
        .mutate<UpdateClubInviteToken$Mutation, UpdateClubInviteTokenArguments>(
            mutation: UpdateClubInviteTokenMutation(variables: variables));

    setState(() => _savingToDB = false);

    if (result.hasErrors || result.data == null) {
      context.showErrorAlert(
          'Sorry there was a problem, the invite link was not updated.');
    } else {
      if (widget.onUpdateComplete != null) {
        widget.onUpdateComplete!(result.data!.updateClubInviteToken);
      }
      context.pop();
    }
  }

  bool get _validToSubmit =>
      _activeToken.name.length > 2 && _activeToken.name.length < 21;

  void _handleCancel() {
    context.showConfirmDialog(
        title: 'Close without saving?', onConfirm: context.pop);
  }

  @override
  void dispose() {
    _inviteLimitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: BorderlessNavBar(
          withoutLeading: true,
          middle: Row(
            children: [
              NavBarLargeTitle(
                  _isCreate ? 'Create Invite Link' : 'Edit Invite Link'),
            ],
          ),
          trailing: _savingToDB
              ? NavBarTrailingRow(children: [NavBarLoadingDots()])
              : NavBarCancelButton(_handleCancel)),
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 16),
          if (!_isCreate)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                      'This link has been used ${_activeToken.joinedUserIds.length} times so far.'),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: MyTextFormFieldRow(
              autofocus: _isCreate,
              backgroundColor: context.theme.cardBackground,
              controller: _nameController,
              placeholder: 'Label (required)',
              keyboardType: TextInputType.text,
              validator: () => _validToSubmit,
              validationMessage: 'Min 3, max 20 characters',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText('Max Invites'),
                SlidingSelect<bool>(
                    value: _enableInviteLimit,
                    updateValue: (v) => setState(() => _enableInviteLimit = v),
                    children: {
                      true: MyText('Custom'),
                      false: MyText('Unlimited'),
                    }),
                InfoPopupButton(
                    infoWidget: MyText('Explian invite link use limit'))
              ],
            ),
          ),
          SizedBox(height: 8),
          GrowInOut(
            show: _enableInviteLimit,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: MyText('Expire after')),
                  Flexible(child: MyNumberInput(_inviteLimitController)),
                  Flexible(child: MyText('have joined.')),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          if (_validToSubmit)
            FadeInUp(
              child: PrimaryButton(
                  loading: _savingToDB,
                  prefix: Icon(
                    _isCreate ? CupertinoIcons.add : CupertinoIcons.pencil,
                    size: 20,
                    color: context.theme.background,
                  ),
                  text: _isCreate ? 'Create Invite Link' : 'Update Invite Link',
                  onPressed: _isCreate
                      ? () => _handleCreate()
                      : () => _handleUpdate()),
            )
        ],
      ),
    );
  }
}
