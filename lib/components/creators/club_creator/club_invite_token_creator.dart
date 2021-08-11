import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/cupertino_switch_row.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/components/user_input/number_input.dart';
import 'package:spotmefitness_ui/components/user_input/number_picker_modal.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/default_object_factory.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class ClubInviteTokenCreator extends StatefulWidget {
  final ClubInviteToken? token;
  const ClubInviteTokenCreator({
    Key? key,
    this.token,
  }) : super(key: key);

  @override
  _ClubInviteTokenCreatorState createState() => _ClubInviteTokenCreatorState();
}

class _ClubInviteTokenCreatorState extends State<ClubInviteTokenCreator> {
  late bool _isCreate;
  bool _savingToDB = false;
  late ClubInviteToken _activeToken;
  late bool _enableInviteLimit;
  final _inviteLimitController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _isCreate = widget.token == null;

    if (!_isCreate) {
      _activeToken = ClubInviteToken.fromJson(widget.token!.toJson());
    } else {
      _activeToken = DefaultObjectfactory.defaultClubInviteToken();
    }

    _inviteLimitController.text = _activeToken.inviteLimit.toString();
    _enableInviteLimit = _activeToken.inviteLimit != 0;

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
    setState(() => _savingToDB = true);

    /// TODO: What do we need to update here? Queries? Local ClubCreator state?
    final variables = CreateClubInviteTokenArguments(
        data: CreateClubInviteTokenInput(
            club: ConnectRelationInput(id: 'NOT DONE'),
            creator: ConnectRelationInput(id: 'NOT DONE'),
            inviteLimit: _activeToken.inviteLimit));

    final result = await context.graphQLStore
        .create<CreateClubInviteToken$Mutation, CreateClubInviteTokenArguments>(
            mutation: CreateClubInviteTokenMutation(variables: variables));

    if (result.hasErrors || result.data == null) {
      context.showErrorAlert(
          'Sorry there was a problem, the invite link was not created.');
    }

    setState(() => _savingToDB = false);
    print('save and then close');
  }

  Future<void> _handleUpdate() async {
    setState(() => _savingToDB = true);

    /// TODO: What do we need to update here? Queries? Local ClubCreator state?
    final variables = UpdateClubInviteTokenArguments(
        data: UpdateClubInviteTokenInput(
            inviteLimit: _activeToken.inviteLimit, id: _activeToken.id));

    final result = await context.graphQLStore
        .create<UpdateClubInviteToken$Mutation, UpdateClubInviteTokenArguments>(
            mutation: UpdateClubInviteTokenMutation(variables: variables));

    if (result.hasErrors || result.data == null) {
      context.showErrorAlert(
          'Sorry there was a problem, the invite link was not updated.');
    }

    setState(() => _savingToDB = false);
    print('save and then close');
  }

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
              ? NavBarLoadingDots()
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
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
          SizedBox(height: 16),
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
          SizedBox(height: 24),
          PrimaryButton(
              prefix: Icon(
                _isCreate ? CupertinoIcons.add : CupertinoIcons.pencil,
                size: 20,
                color: context.theme.background,
              ),
              text: _isCreate ? 'Create Invite Link' : 'Update Invite Link',
              onPressed:
                  _isCreate ? () => _handleCreate() : () => _handleUpdate())
        ],
      ),
    );
  }
}
