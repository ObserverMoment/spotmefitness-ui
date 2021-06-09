import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/workout_plan_creator_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/navigation.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class WorkoutPlanCreatorPage extends StatefulWidget {
  final WorkoutPlan? workoutPlan;
  const WorkoutPlanCreatorPage({Key? key, this.workoutPlan}) : super(key: key);

  @override
  _WorkoutPlanCreatorPageState createState() => _WorkoutPlanCreatorPageState();
}

class _WorkoutPlanCreatorPageState extends State<WorkoutPlanCreatorPage> {
  int _activeTabIndex = 0;
  WorkoutPlan? _workoutPlan;
  final PageController _pageController = PageController();
  late bool _isCreate;

  @override
  void initState() {
    super.initState();
    _isCreate = widget.workoutPlan == null;
  }

  Future<WorkoutPlan> _initWorkoutPlan() async {
    if (_workoutPlan != null) {
      return _workoutPlan!;
    } else {
      _workoutPlan =
          await WorkoutPlanCreatorBloc.initialize(context, widget.workoutPlan);
      return _workoutPlan!;
    }
  }

  void _changeTab(int index) {
    _pageController.jumpToPage(
      index,
    );
    Utils.hideKeyboard(context);
    setState(() => _activeTabIndex = index);
  }

  void _saveAndClose(BuildContext context) {
    final success = context.read<WorkoutPlanCreatorBloc>().saveAllChanges();
    if (success) {
      context.pop();
    } else {
      context.showErrorAlert(
          'Sorry there was a problem updating, please try again.');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilderHandler<WorkoutPlan>(
        loadingWidget: CupertinoPageScaffold(
          navigationBar: BorderlessNavBar(
            automaticallyImplyLeading: false,
            middle: NavBarTitle('Getting ready...'),
          ),
          child: Center(
            child: LoadingCircle(),
          ),
        ),
        future: _initWorkoutPlan(),
        builder: (initialWorkout) => ChangeNotifierProvider(
              create: (context) => WorkoutPlanCreatorBloc(),
              builder: (context, child) {
                final bool formIsDirty =
                    context.select<WorkoutPlanCreatorBloc, bool>(
                        (bloc) => bloc.formIsDirty);

                final bool uploadingMedia =
                    context.select<WorkoutPlanCreatorBloc, bool>(
                        (b) => b.uploadingMedia);

                final String name =
                    context.select<WorkoutPlanCreatorBloc, String>(
                        (bloc) => bloc.workoutPlan.name);

                return CupertinoPageScaffold(
                  navigationBar: CreateEditPageNavBar(
                    handleClose: context.pop,
                    handleSave: () => _saveAndClose(context),
                    saveText: 'Done',

                    /// You always need to run the bloc.saveAllUpdates fn when creating.
                    /// i.e when [widget.workout == null]
                    formIsDirty: widget.workoutPlan == null || formIsDirty,

                    /// Disable save / done while media is uploading.
                    inputValid: !uploadingMedia && name.length >= 3,
                    title: widget.workoutPlan == null
                        ? 'New Workout'
                        : 'Edit Workout',
                  ),
                  child: Column(
                    children: [
                      if (uploadingMedia)
                        FadeIn(
                          child: Container(
                              height: 30,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  MyText('Uploading media, please wait...'),
                                  SizedBox(width: 8),
                                  LoadingDots(
                                    size: 12,
                                  )
                                ],
                              )),
                        )
                      else
                        FadeIn(
                          child: MyTabBarNav(
                              titles: ['Meta', 'Structure', 'Media'],
                              handleTabChange: _changeTab,
                              activeTabIndex: _activeTabIndex),
                        ),
                      Expanded(
                          child: PageView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: _changeTab,
                        children: [
                          MyText('Meta'),
                          MyText('Structure'),
                          MyText('Media'),
                        ],
                      )),
                    ],
                  ),
                );
              },
            ));
  }
}
