import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/animated/loading_shimmers.dart';
import 'package:sofie_ui/components/cards/card.dart';
import 'package:sofie_ui/components/cards/workout_plan_card.dart';
import 'package:sofie_ui/components/tags.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/workout_plan_enrolment/workout_plan_enrolment_progress_summary.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/services/store/query_observer.dart';

class YourWorkoutPlanEnrolments extends StatelessWidget {
  final void Function(String enrolmentId) selectEnrolledPlan;
  const YourWorkoutPlanEnrolments({Key? key, required this.selectEnrolledPlan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserWorkoutPlanEnrolments$Query,
        json.JsonSerializable>(
      key: Key(
          'YourWorkoutPlanEnrolments - ${UserWorkoutPlanEnrolmentsQuery().operationName}'),
      query: UserWorkoutPlanEnrolmentsQuery(),
      loadingIndicator: const ShimmerCardList(itemCount: 20, cardHeight: 260),
      builder: (data) {
        final enrolments = data.userWorkoutPlanEnrolments
            .sortedBy<DateTime>((w) => w.startDate)
            .reversed
            .toList();

        return _FilterableEnroledPlans(
          allEnrolments: enrolments,
          selectEnrolledPlan: selectEnrolledPlan,
        );
      },
    );
  }
}

class _FilterableEnroledPlans extends StatefulWidget {
  final void Function(String enrolmentId) selectEnrolledPlan;
  final List<WorkoutPlanEnrolment> allEnrolments;
  const _FilterableEnroledPlans(
      {Key? key, required this.selectEnrolledPlan, required this.allEnrolments})
      : super(key: key);

  @override
  __FilterableEnroledPlansState createState() =>
      __FilterableEnroledPlansState();
}

class __FilterableEnroledPlansState extends State<_FilterableEnroledPlans> {
  WorkoutTag? _workoutTagFilter;

  @override
  Widget build(BuildContext context) {
    final allTags = widget.allEnrolments
        .map((e) => e.workoutPlan)
        .fold<List<WorkoutTag>>(
            [], (acum, next) => [...acum, ...next.workoutTags])
        .toSet()
        .toList();

    final filteredEnrolments = _workoutTagFilter == null
        ? widget.allEnrolments
        : widget.allEnrolments.where(
            (e) => e.workoutPlan.workoutTags.contains(_workoutTagFilter));

    final sortedEnrolments = filteredEnrolments
        .sortedBy<DateTime>((w) => w.startDate)
        .reversed
        .toList();

    return Column(
      children: [
        if (allTags.isNotEmpty)
          Padding(
            padding:
                const EdgeInsets.only(left: 4.0, top: 4, bottom: 10, right: 4),
            child: SizedBox(
                height: 30,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: allTags.length,
                    itemBuilder: (c, i) => Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: SelectableTag(
                            text: allTags[i].tag,
                            selectedColor: Styles.infoBlue,
                            isSelected: allTags[i] == _workoutTagFilter,
                            onPressed: () => setState(() => _workoutTagFilter =
                                allTags[i] == _workoutTagFilter
                                    ? null
                                    : allTags[i]),
                          ),
                        ))),
          ),
        Expanded(
            child: sortedEnrolments.isEmpty
                ? const Center(child: MyText('No enrolments to display'))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: sortedEnrolments.length,
                    itemBuilder: (c, i) => GestureDetector(
                          onTap: () =>
                              widget.selectEnrolledPlan(sortedEnrolments[i].id),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 4),
                            child: Card(
                              padding: const EdgeInsets.all(1),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 9),
                                    child: WorkoutPlanEnrolmentProgressSummary(
                                        workoutPlanEnrolment:
                                            sortedEnrolments[i]),
                                  ),
                                  WorkoutPlanCard(
                                    sortedEnrolments[i].workoutPlan,
                                    withBoxShadow: false,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))),
      ],
    );
  }
}
