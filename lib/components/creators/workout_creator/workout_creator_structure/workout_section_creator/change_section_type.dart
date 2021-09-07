import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/tags.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/timecap_picker.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/workout_section_type_multi_selector.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/data_type_extensions.dart';

/// This screen is for when the user is changing the section type - to ensure that correct fields are copied or removed - as required depending on the type. Pass [previousSection] for this.
class ChangeSectionType extends StatefulWidget {
  final WorkoutSection previousSection;
  final void Function(WorkoutSection workoutSection) updatedWorkoutSection;
  const ChangeSectionType(
      {Key? key,
      required this.previousSection,
      required this.updatedWorkoutSection})
      : super(key: key);

  @override
  _ChangeSectionTypeState createState() => _ChangeSectionTypeState();
}

class _ChangeSectionTypeState extends State<ChangeSectionType> {
  late WorkoutSection _workoutSection;

  @override
  void initState() {
    super.initState();
    _workoutSection = WorkoutSection.fromJson(widget.previousSection.toJson());
  }

  void _handleUpdateSelectedType(WorkoutSectionType type) {
    _workoutSection.workoutSectionType = type;

    if (type.name == kAMRAPName) {
      _openTimecapPicker();
    }
    setState(() {});
  }

  void _openTimecapPicker() {
    context.showBottomSheet(
        showDragHandle: false,
        expand: false,
        child: TimecapPopup(
            timecap: Duration(seconds: _workoutSection.timecap),
            allowNoTimecap: false,
            title: 'AMRAP in how long?',
            saveTimecap: (timecap) {
              if (timecap != null) {
                _workoutSection.timecap = timecap.inSeconds;
              }
              setState(() {});
            }));
  }

  void _saveAndClose() {
    widget.updatedWorkoutSection(_workoutSection);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: MyNavBar(
        customLeading: NavBarCancelButton(context.pop),
        middle: NavBarTitle('Change Section Type'),
        trailing: NavBarSaveButton(_saveAndClose),
      ),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: MyHeaderText('Selected type'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: WorkoutSectionTypeTag(
                  _workoutSection.workoutSectionType.name,
                  timecap:
                      _workoutSection.isAMRAP ? _workoutSection.timecap : null,
                  fontSize: FONTSIZE.BIG,
                ),
              ),
            ],
          ),
          WorkoutSectionTypeMultiSelector(
            selectedTypes: [_workoutSection.workoutSectionType],
            allowMultiSelect: false,
            direction: Axis.vertical,
            hideTitle: true,
            updateSelectedTypes: (types) => _handleUpdateSelectedType(types[0]),
          ),
        ],
      ),
    );
  }
}
