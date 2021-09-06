import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// When adding a new section this screen opens to allow the user to select the section type and any required attributes for that section type. Should return a [WorkoutSection] which can then be passed to the bloc for creation.
/// This screen can also be used when the user is changing the section type - to ensure that correct fields are copied or removed - as required depending on the type. Pass [previousSection] for this.
class AddWorkoutSection extends StatefulWidget {
  final WorkoutSection? previousSection;
  final void Function(CreateWorkoutSectionInput createWorkoutSectionInput)
      createWorkoutSection;
  const AddWorkoutSection(
      {Key? key, this.previousSection, required this.createWorkoutSection})
      : super(key: key);

  @override
  _AddWorkoutSectionState createState() => _AddWorkoutSectionState();
}

class _AddWorkoutSectionState extends State<AddWorkoutSection> {
  CreateWorkoutSectionInput? createWorkoutSectionInput;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: MyNavBar(
        customLeading: NavBarCancelButton(context.pop),
        middle: NavBarTitle(widget.previousSection != null
            ? 'Change Section Type'
            : 'Add Section'),
        trailing: NavBarSaveButton(
            () => widget.createWorkoutSection(createWorkoutSectionInput!)),
      ),
      child: MyText('Add fields'),
    );
  }
}
