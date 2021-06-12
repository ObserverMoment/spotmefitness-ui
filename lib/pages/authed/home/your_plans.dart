import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/workout_plan_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/services/text_search_filters.dart';
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
              children: [YourCreatedWorkoutPlans(), YourEnrolledWorkoutPlans()],
            ))
          ],
        ));
  }
}

class YourCreatedWorkoutPlans extends StatelessWidget {
  const YourCreatedWorkoutPlans({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserWorkoutPlans$Query, json.JsonSerializable>(
      key: Key(
          'YourWorkoutPlansPage - ${UserWorkoutPlansQuery().operationName}'),
      query: UserWorkoutPlansQuery(),
      garbageCollectAfterFetch: true,
      loadingIndicator: ShimmerCardList(itemCount: 20, cardHeight: 260),
      builder: (data) {
        final workoutPlans = data.userWorkoutPlans
            .sortedBy<DateTime>((w) => w.createdAt)
            .reversed
            .toList();

        return FilterableWorkoutPlansList(workoutPlans);
      },
    );
  }
}

class FilterableWorkoutPlansList extends StatelessWidget {
  final List<WorkoutPlan> workoutPlans;
  FilterableWorkoutPlansList(this.workoutPlans);

  void _openWorkoutPlanDetails(BuildContext context, String id) {
    context.navigateTo(WorkoutPlanDetailsRoute(id: id));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        workoutPlans.isEmpty
            ? Center(child: MyText('No plans to display...'))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: workoutPlans.length + 1,
                  itemBuilder: (c, i) {
                    if (i == workoutPlans.length) {
                      return SizedBox(height: 58);
                    } else {
                      return GestureDetector(
                        onTap: () => _openWorkoutPlanDetails(
                            context, workoutPlans[i].id),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4.0),
                          child: WorkoutPlanCard(workoutPlans[i]),
                        ),
                      );
                    }
                  },
                ),
              ),
        Positioned(
            bottom: kBottomNavBarHeight + 10,
            child: SortFilterSearchFloatingButton(
              onFilterPress: () => print('TODO - implement workout filters'),
              onSortPress: () => print('TODO - implement workout sort'),
              onSearchPress: () => context.push(
                  fullscreenDialog: true,
                  rootNavigator: true,
                  child: YourWorkoutPlansTextSearch(
                      allWorkoutPlans: workoutPlans,
                      selectWorkoutPlan: (w) =>
                          _openWorkoutPlanDetails(context, w.id))),
            ))
      ],
    );
  }
}

class YourWorkoutPlansTextSearch extends StatefulWidget {
  final List<WorkoutPlan> allWorkoutPlans;
  final void Function(WorkoutPlan workoutPLan) selectWorkoutPlan;

  YourWorkoutPlansTextSearch(
      {required this.allWorkoutPlans, required this.selectWorkoutPlan});

  @override
  _YourWorkoutPlansTextSearchState createState() =>
      _YourWorkoutPlansTextSearchState();
}

class _YourWorkoutPlansTextSearchState
    extends State<YourWorkoutPlansTextSearch> {
  String _searchString = '';
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  void _handleSelectWorkoutPlan(WorkoutPlan workoutPlan) {
    widget.selectWorkoutPlan(workoutPlan);
    context.pop();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredWorkoutPlans = TextSearchFilters.workoutPlansBySearchString(
        widget.allWorkoutPlans, _searchString);

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: CupertinoSearchTextField(
                        focusNode: _focusNode,
                        onChanged: (value) =>
                            setState(() => _searchString = value.toLowerCase()),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  NavBarCloseButton(context.pop),
                ],
              ),
            ),
            Expanded(
              child: FadeIn(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: filteredWorkoutPlans
                        .sortedBy<String>((workoutPlan) => workoutPlan.name)
                        .map((workoutPlan) => GestureDetector(
                            onTap: () => _handleSelectWorkoutPlan(workoutPlan),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4.0),
                              child: WorkoutPlanCard(workoutPlan),
                            )))
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class YourEnrolledWorkoutPlans extends StatelessWidget {
  const YourEnrolledWorkoutPlans({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserWorkoutPlanEnrolments$Query,
        json.JsonSerializable>(
      key: Key(
          'YourWorkoutPlansPage - ${UserWorkoutPlanEnrolmentsQuery().operationName}'),
      query: UserWorkoutPlanEnrolmentsQuery(),
      garbageCollectAfterFetch: true,
      loadingIndicator: ShimmerCardList(itemCount: 20, cardHeight: 260),
      builder: (data) {
        final enrolments = data.userWorkoutPlanEnrolments
            .sortedBy<DateTime>((w) => w.startDate)
            .reversed
            .toList();

        return ListView(
          children: enrolments.map((e) => MyText(e.id)).toList(),
        );
      },
    );
  }
}
