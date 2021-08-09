import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/text_input.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class ClubCreatorPage extends StatefulWidget {
  final Club? club;
  final void Function(Club Club)? onComplete;
  const ClubCreatorPage({
    Key? key,
    this.club,
    this.onComplete,
  }) : super(key: key);

  @override
  _ClubCreatorPageState createState() => _ClubCreatorPageState();
}

class _ClubCreatorPageState extends State<ClubCreatorPage> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  bool _loading = false;
  late bool _isCreate;

  @override
  void initState() {
    _isCreate = widget.club == null;

    _nameController = TextEditingController(text: widget.club?.name);
    _descriptionController =
        TextEditingController(text: widget.club?.description);

    _nameController.addListener(() {
      setState(() {});
    });
    _descriptionController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  void _handleSave() {
    if (_nameController.text.length > 2) {
      if (widget.club != null) {
        _updateClub();
      } else {
        _createClub();
      }
    }
  }

  Future<void> _updateClub() async {
    // setState(() => _loading = true);

    // final variables = UpdateClubArguments(
    //     data: UpdateClubInput(
    //         id: widget.club!.id,
    //         name: _nameController.text,
    //         description: _descriptionController.text));

    // final result = await context.graphQLStore
    //     .mutate<UpdateClub$Mutation, UpdateClubArguments>(
    //   mutation: UpdateClubMutation(variables: variables),
    //   broadcastQueryIds: [
    //     UserClubsQuery().operationName,
    //     GQLVarParamKeys.userClubByIdQuery(widget.Club!.id)
    //   ],
    // );

    // setState(() => _loading = false);

    // if (result.hasErrors || result.data == null) {
    //   context.showErrorAlert(
    //       'Sorry there was a problem, the Club was not created.');
    // } else {
    //   if (widget.onComplete != null) {
    //     widget.onComplete!(result.data!.updateClub);
    //   }
    //   context.pop();
    // }
  }

  Future<void> _createClub() async {
    // setState(() => _loading = true);

    // final variables = CreateClubArguments(
    //     data: CreateClubInput(
    //         name: _nameController.text,
    //         description: _descriptionController.text));

    // final result = await context.graphQLStore
    //     .mutate<CreateClub$Mutation, CreateClubArguments>(
    //         mutation: CreateClubMutation(variables: variables),
    //         addRefToQueries: [UserClubsQuery().operationName]);

    // setState(() => _loading = false);

    // if (result.hasErrors || result.data == null) {
    //   context.showErrorAlert(
    //       'Sorry there was a problem, the Club was not created.');
    // } else {
    //   if (widget.onComplete != null) {
    //     widget.onComplete!(result.data!.createClub);
    //   }
    //   context.pop();
    // }
  }

  void _cancel() {
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
    return CupertinoPageScaffold(
      backgroundColor: context.theme.modalBackground,
      navigationBar: BorderlessNavBar(
        backgroundColor: context.theme.modalBackground,
        customLeading: NavBarCancelButton(_cancel),
        middle: NavBarTitle(_isCreate ? 'Create Club' : 'Edit Club'),
        trailing: AnimatedSwitcher(
            duration: Duration(milliseconds: 250),
            child: _loading
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LoadingDots(
                        size: 12,
                        color: Styles.infoBlue,
                      ),
                    ],
                  )
                : _nameController.text.length > 2
                    ? NavBarSaveButton(_handleSave)
                    : Container(width: 0)),
      ),
      // Use SafeArea as this screen is opened as a bottom sheet.
      child: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Column(
          children: [
            CupertinoFormSection.insetGrouped(
              backgroundColor: context.theme.modalBackground,
              children: [
                MyTextFormFieldRow(
                  autofocus: true,
                  controller: _nameController,
                  placeholder: 'Name',
                  keyboardType: TextInputType.text,
                  validator: () =>
                      _nameController.text.length > 2 &&
                      _nameController.text.length < 21,
                  validationMessage: 'Min 3, max 20 characters',
                ),
              ],
            ),
            CupertinoFormSection.insetGrouped(
              backgroundColor: context.theme.modalBackground,
              children: [
                MyTextAreaFormFieldRow(
                    placeholder: 'Description (optional)',
                    keyboardType: TextInputType.text,
                    controller: _descriptionController),
              ],
            ),
          ],
        ),
      ))),
    );
  }
}
