import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/media/images/image_uploader.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/enum.dart';
import 'package:spotmefitness_ui/services/default_object_factory.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/uploadcare.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:spotmefitness_ui/extensions/enum_extensions.dart';

/// File cleanup on the Uploadcare server is being handled inline within this component.
/// This is because unlike some other Creators saving does not happen immediately / incrementally. It only happens when the user hits 'save'.
/// So if they delete / update the cover image then we need to clean up the media - the API will not do this at the moment.
/// This should be reviewed. It may be best to implement incremental saving in the same way as in WorkoutCreator, but this will require creating a journal on initialization - considered minor / non-urgent work - 28/07/21.
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

  void _updateBodyweightUnit(BodyweightUnit bodyweightUnit) => setState(() {
        _formIsDirty = true;
        _activeProgressJournal.bodyweightUnit = bodyweightUnit;
      });

  Future<void> _updateCoverImageUri(String coverImageUri) async {
    _formIsDirty = true;
    final coverImageForDeletion = _activeProgressJournal.coverImageUri;

    /// Running two separate series [setState] calls in this method to avoid flash of previous image at the end of the updating process.
    setState(() {
      /// Set the new coverImageUri which has already been uploaded.
      _activeProgressJournal.coverImageUri = coverImageUri;
    });

    /// Remove file from media server - see docs at top of widget.
    if (Utils.textNotNull(coverImageForDeletion)) {
      try {
        await UploadcareService()
            .deleteFiles(fileIds: [coverImageForDeletion!]);
      } catch (e) {
        context.showToast(
            message: 'Sorry there was a problem updating the cover image',
            toastType: ToastType.destructive);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _removeCoverImageUri() async {
    _formIsDirty = true;
    try {
      await UploadcareService()
          .deleteFiles(fileIds: [_activeProgressJournal.coverImageUri!]);

      /// Clear the coverImageUri field.
      _activeProgressJournal.coverImageUri = null;
    } catch (e) {
      context.showToast(
          message: 'Sorry there was a problem removing the cover image',
          toastType: ToastType.destructive);
    } finally {
      _isLoading = false;
    }
    setState(() {});
  }

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
      final variables = UpdateProgressJournalArguments(
          data: UpdateProgressJournalInput(
              id: _activeProgressJournal.id,
              name: _activeProgressJournal.name,
              description: _activeProgressJournal.description,
              coverImageUri: _activeProgressJournal.coverImageUri,
              bodyweightUnit: _activeProgressJournal.bodyweightUnit));

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
              description: _activeProgressJournal.description,
              coverImageUri: _activeProgressJournal.coverImageUri,
              bodyweightUnit: _activeProgressJournal.bodyweightUnit));

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
    return MyPageScaffold(
      // Non standard nav bar (not [CreateEdit] version as the journal is not created immediately on init of this widget (as is the case for workot creator), but only when user hits save. So there needs to be different cancel / close logic to handle user bailing out of a create op.
      navigationBar: BorderlessNavBar(
        customLeading: Align(
            alignment: Alignment.centerLeft,
            child: NavBarTitle(_isEditing ? 'Edit Journal' : 'Create Journal')),
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
              title: 'Description',
              text: _activeProgressJournal.description ?? '',
              onSave: _updateDescription,
              maxDisplayLines: 6,
              inputValidation: (t) => true),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                MyText('Cover Image'),
                SizedBox(height: 8),
                ImageUploader(
                  imageUri: _activeProgressJournal.coverImageUri,
                  onUploadSuccess: _updateCoverImageUri,
                  displaySize: Size(250, 250),
                  removeImage: (_) => _removeCoverImageUri(),
                  onUploadStart: () => setState(() => _isLoading = true),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText('Bodyweight Unit'),
                SlidingSelect<BodyweightUnit>(
                    value: _activeProgressJournal.bodyweightUnit,
                    children: {
                      for (final v in BodyweightUnit.values
                          .where((v) => v != BodyweightUnit.artemisUnknown))
                        v: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: MyText(v.display.toUpperCase()))
                    },
                    updateValue: _updateBodyweightUnit),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
