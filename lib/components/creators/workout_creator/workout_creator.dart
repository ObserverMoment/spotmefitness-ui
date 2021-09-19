import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/creators/workout_creator/workout_creator_media.dart';
import 'package:spotmefitness_ui/components/creators/workout_creator/workout_creator_meta.dart';
import 'package:spotmefitness_ui/components/creators/workout_creator/workout_creator_structure/workout_creator_structure.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/text_row_click_to_edit.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/content_access_scope_selector.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/difficulty_level_selector.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.graphql.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/services/graphql_operation_names.dart';
import 'package:spotmefitness_ui/services/store/store_utils.dart';

class WorkoutCreatorPage extends StatefulWidget {
  /// For use when editing or duplicating a workout.
  final Workout? workout;
  WorkoutCreatorPage({this.workout});

  @override
  _WorkoutCreatorPageState createState() => _WorkoutCreatorPageState();
}

class _WorkoutCreatorPageState extends State<WorkoutCreatorPage> {
  WorkoutCreatorBloc? _bloc;
  bool _creatingNewWorkout = false;

  @override
  void initState() {
    super.initState();
    if (widget.workout != null) {
      _initBloc(widget.workout!);
    }
  }

  /// Create a bare bones workout in the DB and add it to the store.
  Future<void> _createWorkout(CreateWorkoutInput input) async {
    setState(() {
      _creatingNewWorkout = true;
    });
    final result = await context.graphQLStore
        .create<CreateWorkout$Mutation, CreateWorkoutArguments>(
            mutation: CreateWorkoutMutation(
                variables: CreateWorkoutArguments(data: input)),
            addRefToQueries: [GQLOpNames.userWorkoutsQuery]);

    await checkOperationResult(context, result, onSuccess: () {
      // Only the [UserSummary] sub field is returned by the create resolver.
      // Add these fields manually to avoid [fromJson] throwing an error.
      _initBloc(Workout.fromJson({
        ...result.data!.createWorkout.toJson(),
        'WorkoutSections': [],
        'WorkoutGoals': [],
        'WorkoutTags': []
      }));
    });

    setState(() {
      _creatingNewWorkout = false;
    });
  }

  void _initBloc(Workout workout) {
    setState(() => _bloc = WorkoutCreatorBloc(context, workout));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: kStandardAnimationDuration,
        child: _bloc != null
            ? MainUI(bloc: _bloc!)
            : PreCreateUI(
                createWorkout: _createWorkout,
                creatingNewWorkout: _creatingNewWorkout));
  }
}

/// Allows user to enter the basic info required to create a workout in the DB.
/// They can also abort here if they want and no workout will be created in the DB.
class PreCreateUI extends StatefulWidget {
  final void Function(CreateWorkoutInput input) createWorkout;
  final bool creatingNewWorkout;
  const PreCreateUI(
      {Key? key, required this.createWorkout, required this.creatingNewWorkout})
      : super(key: key);

  @override
  _PreCreateUIState createState() => _PreCreateUIState();
}

class _PreCreateUIState extends State<PreCreateUI> {
  late CreateWorkoutInput _createWorkoutInput;

  @override
  void initState() {
    super.initState();
    _createWorkoutInput = CreateWorkoutInput(
        name: 'Workout ${DateTime.now().dateString}',
        difficultyLevel: DifficultyLevel.challenging,
        contentAccessScope: ContentAccessScope.private);
  }

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
      navigationBar: MyNavBar(
        customLeading: NavBarCancelButton(context.pop),
        middle: NavBarTitle('New Workout'),
        trailing: widget.creatingNewWorkout
            ? NavBarTrailingRow(
                children: [
                  NavBarLoadingDots(),
                ],
              )
            : NavBarSaveButton(() => widget.createWorkout(_createWorkoutInput),
                text: 'Create'),
      ),
      child: ListView(children: [
        EditableTextFieldRow(
          title: 'Name',
          text: _createWorkoutInput.name,
          onSave: (t) => setState(() => _createWorkoutInput.name = t),
          inputValidation: (t) => t.length > 2 && t.length <= 50,
          maxChars: 50,
          validationMessage: 'Required. Min 3 chars. max 50',
        ),
        DifficultyLevelSelectorRow(
          difficultyLevel: _createWorkoutInput.difficultyLevel,
          updateDifficultyLevel: (level) =>
              setState(() => _createWorkoutInput.difficultyLevel = level),
        ),
        ContentAccessScopeSelector(
            contentAccessScope: _createWorkoutInput.contentAccessScope,
            updateContentAccessScope: (scope) =>
                setState(() => _createWorkoutInput.contentAccessScope = scope)),
      ]),
    );
  }
}

/// Edit workout UI. We land here if the user is editing an existing workout or after they have just created a new workout and have submitted required fields.
class MainUI extends StatefulWidget {
  final WorkoutCreatorBloc bloc;
  const MainUI({Key? key, required this.bloc}) : super(key: key);

  @override
  _MainUIState createState() => _MainUIState();
}

class _MainUIState extends State<MainUI> {
  int _activeTabIndex = 0;

  void _saveAndClose() {
    final success = widget.bloc.saveAllChanges();

    if (success) {
      context.pop();
    } else {
      context.showConfirmDialog(
          title: 'Oh dear..!',
          content: MyText('Sorry, there was an issue saving!'),
          confirmText: 'Leave without saving',
          cancelText: 'Go back and try again',
          onConfirm: context.pop);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WorkoutCreatorBloc>.value(
      value: widget.bloc,
      builder: (context, _) {
        final bool uploadingMedia =
            context.select<WorkoutCreatorBloc, bool>((b) => b.uploadingMedia);
        final bool creatingSection =
            context.select<WorkoutCreatorBloc, bool>((b) => b.creatingSection);
        final bool creatingSet =
            context.select<WorkoutCreatorBloc, bool>((b) => b.creatingSet);
        final bool creatingMove =
            context.select<WorkoutCreatorBloc, bool>((b) => b.creatingMove);

        return MyPageScaffold(
          navigationBar: MyNavBar(
            withoutLeading: true,
            middle: LeadingNavBarTitle(
              'Workout',
              fontSize: FONTSIZE.MAIN,
            ),
            trailing:
                uploadingMedia || creatingSection || creatingSet || creatingMove
                    ? NavBarTrailingRow(
                        children: [
                          NavBarLoadingDots(),
                        ],
                      )
                    : NavBarSaveButton(
                        _saveAndClose,
                        text: 'Done',
                      ),
          ),
          child: Column(
            children: [
              AnimatedSwitcher(
                duration: kStandardAnimationDuration,
                child: uploadingMedia
                    ? Container(
                        height: 46,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            MyText('Uploading media, please wait...'),
                            SizedBox(width: 8),
                            LoadingDots(
                              size: 12,
                            )
                          ],
                        ))
                    : MyTabBarNav(
                        titles: ['Meta', 'Structure', 'Media'],
                        handleTabChange: (i) =>
                            setState(() => _activeTabIndex = i),
                        activeTabIndex: _activeTabIndex),
              ),
              Expanded(
                child: IndexedStack(
                  index: _activeTabIndex,
                  sizing: StackFit.expand,
                  children: [
                    WorkoutCreatorMeta(),
                    WorkoutCreatorStructure(),
                    WorkoutCreatorMedia()
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
