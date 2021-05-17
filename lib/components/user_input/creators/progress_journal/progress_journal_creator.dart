import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/default_object_factory.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class ProgressJournalCreator extends StatefulWidget {
  final ProgressJournal? progressJournal;
  ProgressJournalCreator({this.progressJournal});

  @override
  _ProgressJournalCreatorState createState() => _ProgressJournalCreatorState();
}

class _ProgressJournalCreatorState extends State<ProgressJournalCreator> {
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

  void _handleSave() async {
    setState(() => _isLoading = true);
    if (_isEditing) {
      final variables = UpdateProgressJournalArguments(
          data: UpdateProgressJournalInput(
              id: _activeProgressJournal.id,
              name: _activeProgressJournal.name,
              description: _activeProgressJournal.description));

      final result = await context.graphQLStore.mutate(
          mutation: UpdateProgressJournalMutation(variables: variables),
          broadcastQueryIds: [UserProgressJournalsQuery().operationName]);

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
      navigationBar: CreateEditPageNavBar(
          title: _isEditing ? 'Edit Journal' : 'Create Journal',
          formIsDirty: _formIsDirty,
          handleSave: _handleSave,
          handleClose: context.pop,
          loading: _isLoading,
          inputValid: true),
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
