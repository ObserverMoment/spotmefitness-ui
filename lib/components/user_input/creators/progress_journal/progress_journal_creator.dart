import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/default_object_factory.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class ProgressJournalCreatorPage extends StatefulWidget {
  final ProgressJournal? progressJournal;
  ProgressJournalCreatorPage({this.progressJournal});

  @override
  _ProgressJournalCreatorPageState createState() =>
      _ProgressJournalCreatorPageState();
}

class _ProgressJournalCreatorPageState
    extends State<ProgressJournalCreatorPage> {
  late ProgressJournal _activeProgressJournal;
  late bool _isEditing;
  bool _formIsDirty = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.progressJournal != null;

    /// When creating, defaults are provided so the form is ready to submit immediately.
    if (!_isEditing) {
      _formIsDirty = true;
    }
    _activeProgressJournal = widget.progressJournal != null
        ? ProgressJournal.fromJson(widget.progressJournal!.toJson())
        : DefaultObjectfactory.defaultProgressJournal();
  }

  void _updateName(String name) => setState(() {
        _formIsDirty = true;
        _activeProgressJournal.name = name;
      });

  void _updateDescription(String description) => setState(() {
        _formIsDirty = true;
        _activeProgressJournal.description = description;
      });

  void _handleClose() {
    if (_formIsDirty) {
      context.showConfirmDialog(
          title: 'Close without saving?', onConfirm: context.pop);
    } else {
      context.pop();
    }
  }

  void _handleSave() async {
    setState(() => _isLoading = true);
    if (_isEditing) {
      print(_activeProgressJournal.description);
      final variables = UpdateProgressJournalArguments(
          data: UpdateProgressJournalInput(
              id: _activeProgressJournal.id,
              name: _activeProgressJournal.name,
              description: _activeProgressJournal.description));

      final result = await context.graphQLStore.mutate(
          mutation: UpdateProgressJournalMutation(variables: variables),
          broadcastQueryIds: [
            UserProgressJournalsQuery().operationName,
            ProgressJournalByIdQuery(
                    variables: ProgressJournalByIdArguments(
                        id: _activeProgressJournal.id))
                .operationName
          ]);

      setState(() => _isLoading = false);

      if (result.hasErrors || result.data == null) {
        context.showToast(
            message: 'Sorry, there was a problem updating the journal',
            toastType: ToastType.destructive);
      } else {
        context.pop();
      }
    } else {
      final variables = CreateProgressJournalArguments(
          data: CreateProgressJournalInput(
              name: _activeProgressJournal.name,
              description: _activeProgressJournal.description));

      final result = await context.graphQLStore.create(
          mutation: CreateProgressJournalMutation(variables: variables),
          addRefToQueries: [UserProgressJournalsQuery().operationName]);

      setState(() => _isLoading = false);

      if (result.hasErrors || result.data == null) {
        context.showToast(
            message: 'Sorry, there was a problem creating the new journal',
            toastType: ToastType.destructive);
      } else {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // Non standard nav bar (not [CreateEdit] version as the journal is not created on init of this widget, but only when user hits save. So there needs to be different cancel / close logic to handle user bailing out of a create op.
      navigationBar: BasicNavBar(
        customLeading:
            NavBarTitle(_isEditing ? 'Edit Journal' : 'Create Journal'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (_isLoading)
              LoadingDots(
                size: 14,
              ),
            if (!_isLoading && !_isEditing)
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: NavBarCancelButton(_handleClose),
              ),
            if (!_isLoading && _isEditing && !_formIsDirty)
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: NavBarCloseButton(_handleClose),
              ),
            if (!_isLoading && _formIsDirty)
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: NavBarSaveButton(_handleSave),
              ),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            EditableTextFieldRow(
                title: 'Name',
                text: _activeProgressJournal.name,
                onSave: _updateName,
                maxChars: 30,
                validationMessage: 'Min 3, max 30 characters',
                isRequired: true,
                inputValidation: (t) => t.length > 2 && t.length < 31),
            EditableTextAreaRow(
                title: 'Ddescription',
                text: _activeProgressJournal.description ?? '',
                onSave: _updateDescription,
                maxDisplayLines: 6,
                inputValidation: (t) => true),
          ],
        ),
      ),
    );
  }
}
