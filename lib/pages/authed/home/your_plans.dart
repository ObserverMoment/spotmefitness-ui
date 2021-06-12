import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/card.dart';
import 'package:spotmefitness_ui/components/cards/workout_plan_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/workout_plan_enrolment/workout_plan_enrolment_progress_summary.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class YourPlansPage extends StatefulWidget {
  @override
  _YourPlansPageState createState() => _YourPlansPageState();
}

class _YourPlansPageState extends State<YourPlansPage> {
  /// 0 = CreatedPlans, 1 = Participating in plans
  int _activeTabIndex = 0;
  PageController _pageController = PageController();

  void _updatePageIndex(int index) {
    setState(() => _activeTabIndex = index);
    _pageController.toPage(_activeTabIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: BorderlessNavBar(
          middle: NavBarTitle('Your Plans'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CreateIconButton(
                  onPressed: () =>
                      context.navigateTo(WorkoutPlanCreatorRoute())),
              InfoPopupButton(
                infoWidget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyText(
                    'Info about this list, the filters, what the icons mean, the different tag types etc',
                    maxLines: 10,
                  ),
                ),
              )
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: SizedBox(
                width: double.infinity,
                child: SlidingSelect<int>(
                    value: _activeTabIndex,
                    updateValue: _updatePageIndex,
                    children: {
                      0: MyText('Created'),
                      1: MyText('Joined'),
                    }),
              ),
            ),
            Expanded(
                child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                YourCreatedWorkoutPlans(),
                YourWorkoutPlanEnrolments()
              ],
            ))
          ],
        ));
  }
}

class YourCreatedWorkoutPlans extends StatelessWidget {
  const YourCreatedWorkoutPlans({Key? key}) : super(key: key);

  void _openWorkoutPlanDetails(BuildContext context, String id) {
    context.navigateTo(WorkoutPlanDetailsRoute(id: id));
  }

  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserWorkoutPlans$Query, json.JsonSerializable>(
      key: Key(
          'YourWorkoutPlansPage - ${UserWorkoutPlansQuery().operationName}'),
      query: UserWorkoutPlansQuery(),
      loadingIndicator: ShimmerCardList(itemCount: 20, cardHeight: 260),
      builder: (data) {
        final workoutPlans = data.userWorkoutPlans
            .sortedBy<DateTime>((w) => w.createdAt)
            .reversed
            .toList();

        return workoutPlans.isEmpty
            ? Center(child: MyText('No plans to display...'))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: workoutPlans.length,
                    itemBuilder: (c, i) => GestureDetector(
                          onTap: () => _openWorkoutPlanDetails(
                              context, workoutPlans[i].id),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4.0),
                            child: WorkoutPlanCard(workoutPlans[i]),
                          ),
                        )),
              );
      },
    );
  }
}

class YourWorkoutPlanEnrolments extends StatelessWidget {
  const YourWorkoutPlanEnrolments({Key? key}) : super(key: key);

  void _openWorkoutPlanEnrolmentDetails(BuildContext context, String id) {
    context.navigateTo(WorkoutPlanEnrolmentDetailsRoute(id: id));
  }

  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserWorkoutPlanEnrolments$Query,
        json.JsonSerializable>(
      key: Key(
          'YourWorkoutPlanEnrolments - ${UserWorkoutPlanEnrolmentsQuery().operationName}'),
      query: UserWorkoutPlanEnrolmentsQuery(),
      loadingIndicator: ShimmerCardList(itemCount: 20, cardHeight: 260),
      builder: (data) {
        final enrolments = data.userWorkoutPlanEnrolments
            .sortedBy<DateTime>((w) => w.startDate)
            .reversed
            .toList();

        return enrolments.isEmpty
            ? Center(child: MyText('No plans joined yet...'))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: enrolments.length,
                    itemBuilder: (c, i) => GestureDetector(
                          onTap: () => _openWorkoutPlanEnrolmentDetails(
                              context, enrolments[i].id),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8),
                            child: Card(
                              padding: EdgeInsets.zero,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 8),
                                    child: WorkoutPlanEnrolmentProgressSummary(
                                        workoutPlanEnrolment: enrolments[i]),
                                  ),
                                  WorkoutPlanCard(
                                    enrolments[i].workoutPlan,
                                    withBoxShadow: false,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
              );
      },
    );
  }
}
