import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/workout_plan_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_plans/your_created_workout_plans.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_plans/your_enroled_workout_plans.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_plans/your_workout_plans_text_search.dart';
import 'package:spotmefitness_ui/pages/authed/home/your_plans/your_saved_workout_plans.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class YourPlansPage extends StatefulWidget {
  @override
  _YourPlansPageState createState() => _YourPlansPageState();
}

class _YourPlansPageState extends State<YourPlansPage> {
  /// 0 = CreatedPlans, 1 = Participating in plans, 2 = saved to collections
  int _activeTabIndex = 0;
  PageController _pageController = PageController();

  void _updatePageIndex(int index) {
    setState(() => _activeTabIndex = index);
    _pageController.toPage(_activeTabIndex);
  }

  void _openWorkoutPlanDetails(String id) {
    context.navigateTo(WorkoutPlanDetailsRoute(id: id));
  }

  void _openWorkoutPlanEnrolmentDetails(String id) {
    context.navigateTo(WorkoutPlanEnrolmentDetailsRoute(id: id));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
        navigationBar: MyNavBar(
          middle: NavBarTitle('Your Plans'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CreateIconButton(
                  onPressed: () =>
                      context.navigateTo(WorkoutPlanCreatorRoute())),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => context.push(
                    rootNavigator: true,
                    child: YourPlansTextSearch(
                      selectWorkoutPlan: (id) => _openWorkoutPlanDetails(id),
                    )),
                child: Icon(CupertinoIcons.search),
              ),
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: SlidingSelect<int>(
                    value: _activeTabIndex,
                    updateValue: _updatePageIndex,
                    children: {
                      0: MyText('Created'),
                      1: MyText('Joined'),
                      2: MyText('Saved'),
                    }),
              ),
            ),
            Expanded(
                child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                YourCreatedWorkoutPlans(
                  selectWorkoutPlan: (id) => _openWorkoutPlanDetails(id),
                ),
                YourWorkoutPlanEnrolments(
                  selectEnrolledPlan: (id) =>
                      _openWorkoutPlanEnrolmentDetails(id),
                ),
                YourSavedPlans(
                  selectWorkoutPlan: (id) => _openWorkoutPlanDetails(id),
                )
              ],
            ))
          ],
        ));
  }
}

class YourWorkoutPlansList extends StatelessWidget {
  final List<WorkoutPlan> workoutPlans;
  final void Function(String workoutPlanId) selectWorkoutPlan;
  const YourWorkoutPlansList(
      {required this.workoutPlans, required this.selectWorkoutPlan});

  @override
  Widget build(BuildContext context) {
    return workoutPlans.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(24),
            child: MyText('No workout plans to display...'))
        : ListView.builder(
            shrinkWrap: true,
            itemCount: workoutPlans.length,
            itemBuilder: (c, i) => GestureDetector(
                  key: Key(workoutPlans[i].id),
                  onTap: () => selectWorkoutPlan(workoutPlans[i].id),
                  child: SizeFadeIn(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: WorkoutPlanCard(workoutPlans[i]),
                    ),
                  ),
                ));
  }
}
