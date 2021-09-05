import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:intl/intl.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/calendar.dart';
import 'package:spotmefitness_ui/components/cards/scheduled_workout_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/model/toast_request.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:collection/collection.dart';

class YourSchedulePage extends StatefulWidget {
  final DateTime? openAtDate;
  YourSchedulePage({this.openAtDate});
  @override
  _YourSchedulePageState createState() => _YourSchedulePageState();
}

class _YourSchedulePageState extends State<YourSchedulePage> {
  final ScrollController _scrollController = ScrollController();
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.openAtDate ?? DateTime.now();
    _focusedDay = _selectedDay;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay,
      List<ScheduledWorkout> allScheduled) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
      });
    }
  }

  Widget? _buildSingleMarker(
      BuildContext context, DateTime dateTime, Object scheduled) {
    final color = (scheduled as ScheduledWorkout).loggedWorkoutId != null
        ? Styles.colorOne // Done
        : scheduled.scheduledAt.isBefore(DateTime.now())
            ? Styles.errorRed // Missed
            : Styles.colorFour; // Upcoming
    return Container(
        height: 8,
        width: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }

  void _findWorkoutToSchedule() => context.navigateTo(
      WorkoutFinderRoute(selectWorkout: (w) => _openScheduleWorkout(w)));

  Future<void> _openScheduleWorkout(Workout workout) async {
    final result = await context.pushRoute(ScheduledWorkoutCreatorRoute(
      workout: workout,
      scheduleOn: _selectedDay,
    ));
    if (result is ToastRequest) {
      context.showToast(message: result.message, toastType: result.type);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserScheduledWorkouts$Query, json.JsonSerializable>(
      key: Key(
          'YourSchedulePage - ${UserScheduledWorkoutsQuery().operationName}'),
      query: UserScheduledWorkoutsQuery(),
      builder: (data) {
        final allScheduled =
            data.userScheduledWorkouts.sortedBy<DateTime>((s) => s.scheduledAt);

        final selectedDayScheduled = allScheduled
            .where((s) => isSameDay(s.scheduledAt, _selectedDay))
            .toList();

        return CupertinoPageScaffold(
            navigationBar: MyNavBar(
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: MyText(
                      DateFormat.yMMM().format(_focusedDay),
                      weight: FontWeight.bold,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => setState(() {
                      _calendarFormat = _calendarFormat == CalendarFormat.week
                          ? CalendarFormat.month
                          : CalendarFormat.week;
                    }),
                    child: _calendarFormat == CalendarFormat.week
                        ? Icon(CupertinoIcons.square_grid_4x3_fill)
                        : Icon(CupertinoIcons.rectangle_split_3x1),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => context.push(
                        rootNavigator: true,
                        child: YourScheduleTextSearch(
                          allScheduledWorkouts: allScheduled,
                        )),
                    child: Icon(CupertinoIcons.search),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: _findWorkoutToSchedule,
                    child: Icon(CupertinoIcons.calendar_badge_plus),
                  ),
                ],
              ),
            ),
            child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Material(
                        color: context.theme.background,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TableCalendar(
                              headerVisible: false,
                              firstDay: DateTime.utc(2021, 01, 01),
                              lastDay: DateTime(DateTime.now().year + 10),
                              focusedDay: _focusedDay,
                              selectedDayPredicate: (day) {
                                return isSameDay(_selectedDay, day);
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                _onDaySelected(
                                    selectedDay, focusedDay, allScheduled);
                              },
                              onPageChanged: (focusedDay) {
                                setState(() {
                                  _focusedDay = focusedDay;
                                });
                              },
                              calendarFormat: _calendarFormat,
                              onFormatChanged: (format) {
                                setState(() {
                                  _calendarFormat = format;
                                });
                              },
                              eventLoader: (day) {
                                return allScheduled
                                    .where((s) => isSameDay(s.scheduledAt, day))
                                    .toList();
                              },
                              calendarBuilders:
                                  CalendarBuilders<List<ScheduledWorkout>>(
                                      singleMarkerBuilder: _buildSingleMarker),
                              daysOfWeekStyle:
                                  CalendarUI.daysOfWeekStyle(context),
                              calendarStyle: CalendarUI.calendarStyle(context)),
                        ),
                      ),
                    )
                  ];
                },
                body: selectedDayScheduled.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(32),
                        child: ListView(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText('Nothing planned...'),
                              ],
                            ),
                            SizedBox(height: 20),
                            SecondaryButton(
                                withBorder: false,
                                prefixIconData:
                                    CupertinoIcons.calendar_badge_plus,
                                text: 'Plan Something',
                                onPressed: _findWorkoutToSchedule),
                          ],
                        ),
                      )
                    : ListView(
                        children: selectedDayScheduled
                            .map((s) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  child: ScheduledWorkoutCard(s),
                                ))
                            .toList(),
                      )));
      },
    );
  }
}

class YourScheduleTextSearch extends StatefulWidget {
  final List<ScheduledWorkout> allScheduledWorkouts;

  YourScheduleTextSearch({required this.allScheduledWorkouts});

  @override
  _YourScheduleTextSearchState createState() => _YourScheduleTextSearchState();
}

class _YourScheduleTextSearchState extends State<YourScheduleTextSearch> {
  String _searchString = '';
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  bool _filter(ScheduledWorkout scheduledWorkout) {
    return scheduledWorkout.workout != null &&
        [
          scheduledWorkout.workout!.name,
          ...scheduledWorkout.workout!.workoutGoals.map((g) => g.name).toList(),
          ...scheduledWorkout.workout!.workoutTags.map((t) => t.tag).toList()
        ]
            .where((t) => Utils.textNotNull(t))
            .map((t) => t.toLowerCase())
            .any((t) => t.contains(_searchString));
  }

  List<ScheduledWorkout> _filterBySearchString() {
    return Utils.textNotNull(_searchString)
        ? widget.allScheduledWorkouts.where((m) => _filter(m)).toList()
        : [];
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredScheduledWorkouts = _filterBySearchString();
    return CupertinoPageScaffold(
      navigationBar: MyNavBar(
        middle: NavBarTitle('Search Your Schedule'),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              ],
            ),
          ),
          Expanded(
            child: FadeIn(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListView(
                  shrinkWrap: true,
                  children: filteredScheduledWorkouts
                      .sortedBy<num>((scheduledWorkout) =>
                          scheduledWorkout.scheduledAt.millisecondsSinceEpoch)
                      .map((scheduledWorkout) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10.0),
                            child: ScheduledWorkoutCard(scheduledWorkout),
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
