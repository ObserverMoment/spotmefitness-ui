import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_route/auto_route.dart';
import 'package:intl/intl.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/cards/scheduled_workout_card.dart';
import 'package:spotmefitness_ui/components/creators/scheduled_workout_creator.dart';
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

  // https://github.com/aleksanderwozniak/table_calendar/issues/498
  final BoxDecoration kDefaultDecoration = BoxDecoration(
      shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10));

  final kBoxDecorationRadius = BorderRadius.circular(10);

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
    final color = (scheduled as ScheduledWorkout).loggedWorkoutSummary != null
        ? Styles.colorOne // Done
        : scheduled.scheduledAt.isBefore(DateTime.now())
            ? Styles.errorRed // Missed
            : Styles.colorFour; // Upcoming
    return Container(
        height: 8,
        width: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }

  Future<void> _openScheduleWorkout(Workout workout) async {
    final result = await context.showBottomSheet(
        showDragHandle: false,
        useRootNavigator: true,
        child: ScheduledWorkoutCreator(
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
    final primaryTextStyle = GoogleFonts.palanquin(
        textStyle:
            TextStyle(color: context.theme.primary, height: 1, fontSize: 15));
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
            navigationBar: BorderlessNavBar(
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: H3(DateFormat.yMMM().format(_focusedDay)),
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
                        child: YourScheduleTextSearch(
                      allScheduledWorkouts: allScheduled,
                    )),
                    child: Icon(CupertinoIcons.search),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => context.navigateTo(WorkoutFinderRoute(
                        selectWorkout: (w) => _openScheduleWorkout(w))),
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
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: primaryTextStyle,
                              weekendStyle: primaryTextStyle,
                            ),
                            calendarStyle: CalendarStyle(
                                markerDecoration: const BoxDecoration(
                                    color: Styles.colorFour,
                                    shape: BoxShape.circle),
                                // https://github.com/aleksanderwozniak/table_calendar/issues/498
                                defaultDecoration: kDefaultDecoration,
                                weekendDecoration: kDefaultDecoration,
                                outsideDecoration: kDefaultDecoration,
                                disabledDecoration: kDefaultDecoration,
                                holidayDecoration: kDefaultDecoration,
                                selectedDecoration: BoxDecoration(
                                    color: context.theme.primary,
                                    shape: BoxShape.rectangle,
                                    borderRadius: kBoxDecorationRadius),
                                todayDecoration: BoxDecoration(
                                    border: Border.all(color: Styles.colorOne),
                                    shape: BoxShape.rectangle,
                                    borderRadius: kBoxDecorationRadius),
                                weekendTextStyle: primaryTextStyle,
                                selectedTextStyle: primaryTextStyle.copyWith(
                                    color: context.theme.background,
                                    fontWeight: FontWeight.bold),
                                todayTextStyle: primaryTextStyle,
                                defaultTextStyle: primaryTextStyle),
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: selectedDayScheduled.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(32),
                        child: Center(child: MyText('Nothing planned...')),
                      )
                    : ListView(
                        children: selectedDayScheduled
                            .map((s) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
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
      navigationBar: BorderlessNavBar(
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
                                horizontal: 4, vertical: 4.0),
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
