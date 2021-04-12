import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/icons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/creators/workout_creator/workout_creator_structure/workout_section_creator/type_creators/free_session_creator.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/workout_section_type_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:provider/provider.dart';

class WorkoutSectionCreator extends StatefulWidget {
  final int editingSectionIndex;
  final bool isCreate;
  WorkoutSectionCreator(this.editingSectionIndex, {this.isCreate = false});

  @override
  _WorkoutSectionCreatorState createState() => _WorkoutSectionCreatorState();
}

class _WorkoutSectionCreatorState extends State<WorkoutSectionCreator> {
  late WorkoutCreatorBloc bloc;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    bloc = context.read<WorkoutCreatorBloc>();
    pageController = PageController(initialPage: widget.isCreate ? 0 : 1);
  }

  void _selectSectionType(WorkoutSectionType type) {
    bloc.updateSection(
        widget.editingSectionIndex, {'WorkoutSectionType': type.toJson()});
    pageController.toPage(1);
  }

  Widget _buildSectionTypeCreator(WorkoutSectionType workoutSectionType) {
    switch (workoutSectionType.name) {
      case 'Free Session':
        return FreeSessionCreator(widget.editingSectionIndex);
      case 'EMOM':
        return FreeSessionCreator(widget.editingSectionIndex);
      default:
        throw new Exception(
            'No builder defined for ${workoutSectionType.name}.');
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final WorkoutSectionType? workoutSectionType =
        context.select<WorkoutCreatorBloc, WorkoutSectionType>((bloc) => bloc
            .workoutData
            .workoutSections[widget.editingSectionIndex]
            .workoutSectionType);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: NavBarTitle('Workout Section'),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Column(
                    children: [
                      MyText('What do you want to create?'),
                      WorkoutSectionTypeSelector(_selectSectionType),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CupertinoButton(
                          onPressed: () => pageController.toPage(0),
                          padding: EdgeInsets.zero,
                          child: WorkoutSectionTypeTag(
                              workoutSectionType?.name ?? '')),
                      if (workoutSectionType != null)
                        _buildSectionTypeCreator(workoutSectionType)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
