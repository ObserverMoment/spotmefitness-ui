import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/calendar.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';
import 'package:table_calendar/table_calendar.dart';

/// Determines which picker is open.
/// https://www.idownloadblog.com/2021/06/09/apple-ios-15-wheel-time-picker/
enum DateTimePickerMode { date, time }

class DateTimePickerDisplay extends StatelessWidget {
  final String title;
  final DateTime? dateTime;
  final bool showDate;
  final bool showTime;
  final void Function(DateTime dateTime) saveDateTime;
  const DateTimePickerDisplay(
      {Key? key,
      required this.dateTime,
      this.showDate = true,
      this.showTime = true,
      this.title = 'When',
      required this.saveDateTime})
      : assert(showDate || showTime),
        super(key: key);

  void _openDateTimePicker(BuildContext context, DateTimePickerMode mode) {
    context.showBottomSheet(
        showDragHandle: false,
        expand: false,
        child: DateTimePicker(
          title: title,
          dateTime: dateTime,
          showDate: showDate,
          showTime: showTime,
          mode: mode,
          saveDateTime: saveDateTime,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return DateTimePickerDisplayRow(
      title: title,
      dateTime: dateTime,
      showDate: showDate,
      showTime: showTime,
      onTapDate: () => _openDateTimePicker(context, DateTimePickerMode.date),
      onTapTime: () => _openDateTimePicker(context, DateTimePickerMode.time),
    );
  }
}

class DateTimePickerDisplayRow extends StatelessWidget {
  final String title;
  final DateTime? dateTime;
  final bool showDate;
  final bool showTime;
  final VoidCallback onTapDate;
  final VoidCallback onTapTime;
  final Color? contextBoxColor;

  /// When being used in picker (rather than in display) - highlight the active picker type display.
  final int? activePickerIndex;
  const DateTimePickerDisplayRow(
      {Key? key,
      required this.dateTime,
      this.showDate = true,
      this.showTime = true,
      this.title = 'When',
      required this.onTapDate,
      required this.onTapTime,
      this.contextBoxColor,
      this.activePickerIndex})
      : assert(showDate || showTime),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color highlightColor = Styles.peachRed;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(title),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showDate)
                GestureDetector(
                  onTap: onTapDate,
                  child: ContentBox(
                      backgroundColor: contextBoxColor,
                      child: MyText(
                        dateTime == null
                            ? 'select date...'
                            : dateTime!.compactDateString,
                        color: activePickerIndex == 0 ? highlightColor : null,
                        weight: activePickerIndex == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                      )),
                ),
              if (showDate && showTime) SizedBox(width: 6),
              if (showTime)
                GestureDetector(
                  onTap: onTapTime,
                  child: ContentBox(
                      backgroundColor: contextBoxColor,
                      child: MyText(
                        dateTime == null
                            ? 'select time...'
                            : dateTime!.timeString,
                        color: activePickerIndex == 1 ? highlightColor : null,
                        weight: activePickerIndex == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                      )),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class DateTimePicker extends StatefulWidget {
  final String title;
  final DateTime? dateTime;
  final bool showDate;
  final bool showTime;
  final DateTimePickerMode mode;
  final void Function(DateTime dateTime) saveDateTime;
  const DateTimePicker(
      {Key? key,
      this.showDate = true,
      this.showTime = true,
      this.mode = DateTimePickerMode.date,
      required this.title,
      this.dateTime,
      required this.saveDateTime})
      : assert(showDate || showTime),
        super(key: key);

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late int _activePickerIndex;
  late DateTime _activeDateTime;

  @override
  void initState() {
    super.initState();
    _activePickerIndex = widget.mode == DateTimePickerMode.date ? 0 : 1;
    _activeDateTime = widget.dateTime ?? DateTime.now();
  }

  void _updateDate(DateTime newDate) {
    final updatedDateTime = DateTime(newDate.year, newDate.month, newDate.day,
        _activeDateTime.hour, _activeDateTime.minute);
    setState(() => _activeDateTime = updatedDateTime);
  }

  void _updateTime(DateTime newTime) {
    final updatedDateTime = DateTime(
        _activeDateTime.year,
        _activeDateTime.month,
        _activeDateTime.day,
        newTime.hour,
        newTime.minute);
    setState(() => _activeDateTime = updatedDateTime);
  }

  void _saveAndClose() {
    widget.saveDateTime(_activeDateTime);
    context.pop();
  }

  String get _buildTitle {
    if (widget.showDate && widget.showTime) {
      return 'Select Date and Time';
    } else if (!widget.showDate) {
      return 'Select Time';
    } else {
      return 'Select Date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CupertinoPageScaffold(
        backgroundColor: context.theme.modalBackground,
        navigationBar: BottomBorderNavBar(
          backgroundColor: context.theme.modalBackground,
          customLeading: NavBarCancelButton(context.pop),
          middle: NavBarTitle(_buildTitle),
          bottomBorderColor: context.theme.navbarBottomBorder,
          trailing: NavBarSaveButton(_saveAndClose),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              DateTimePickerDisplayRow(
                  title: widget.title,
                  dateTime: _activeDateTime,
                  showDate: widget.showDate,
                  showTime: widget.showTime,
                  contextBoxColor: context.theme.background,
                  onTapDate: () => setState(() => _activePickerIndex = 0),
                  onTapTime: () => setState(() => _activePickerIndex = 1),
                  activePickerIndex: _activePickerIndex),
              SizedBox(height: 10),
              ContentBox(
                backgroundColor: context.theme.background,
                child: IndexedStack(
                  index: _activePickerIndex,
                  children: [
                    GrowInOut(
                        show: _activePickerIndex == 0,
                        child: DatePickerCalendar(
                          dateTime: _activeDateTime,
                          updateDateTime: _updateDate,
                        )),
                    GrowInOut(
                        show: _activePickerIndex == 1,
                        child: TimePicker(
                          dateTime: _activeDateTime,
                          updateDateTime: _updateTime,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Will only update the years, months and days.
/// Will maintain the original hours and minutes.
class DatePickerCalendar extends StatefulWidget {
  final DateTime? dateTime;
  final void Function(DateTime date) updateDateTime;
  const DatePickerCalendar(
      {Key? key, required this.dateTime, required this.updateDateTime})
      : super(key: key);

  @override
  _DatePickerCalendarState createState() => _DatePickerCalendarState();
}

class _DatePickerCalendarState extends State<DatePickerCalendar> {
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.dateTime ?? DateTime.now();
  }

  void _onDaySelected(DateTime selected, DateTime _) {
    widget.updateDateTime(selected);
    setState(() {
      _selectedDay = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoButton(
                onPressed: () => print('open month and year picker'),
                child: Row(
                  children: [
                    MyText(
                      'April 2021',
                      weight: FontWeight.bold,
                      size: FONTSIZE.BIG,
                    ),
                    SizedBox(width: 4),
                    Icon(
                      CupertinoIcons.chevron_right,
                      size: 18,
                    ),
                  ],
                )),
            Row(
              children: [
                CupertinoButton(
                  onPressed: () => print('back a month'),
                  child: Icon(
                    CupertinoIcons.chevron_left,
                  ),
                ),
                CupertinoButton(
                  onPressed: () => print('forward a month'),
                  child: Icon(
                    CupertinoIcons.chevron_right,
                  ),
                ),
              ],
            ),
          ],
        ),
        Material(
          color: context.theme.background,
          child: TableCalendar(
              headerVisible: false,
              onDaySelected: _onDaySelected,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _selectedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              daysOfWeekStyle: CalendarUI.daysOfWeekStyle(context),
              calendarStyle: CalendarUI.calendarStyle(context)),
        ),
      ],
    );
  }
}

/// Will only update the hours and minutes.
/// Will maintain the original years, months and days.
class TimePicker extends StatefulWidget {
  final DateTime? dateTime;
  final void Function(DateTime date) updateDateTime;
  const TimePicker(
      {Key? key, required this.dateTime, required this.updateDateTime})
      : super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late DateTime _activeDateTime;

  @override
  void initState() {
    super.initState();
    _activeDateTime = widget.dateTime ?? DateTime.now();
  }

  void onDateTimeChanged(DateTime selected) {
    widget.updateDateTime(selected);
    setState(() {
      _activeDateTime = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: CupertinoDatePicker(
        initialDateTime: _activeDateTime,
        mode: CupertinoDatePickerMode.time,
        onDateTimeChanged: onDateTimeChanged,
      ),
    );
  }
}

class DatePickerDisplay extends StatelessWidget {
  final DateTime? dateTime;
  final void Function(DateTime d) updateDateTime;
  final DateTime? earliestAllowedDate;
  final String title;
  DatePickerDisplay(
      {required this.updateDateTime,
      this.title = 'Date',
      this.dateTime,
      this.earliestAllowedDate});

  Future<void> _openDatePicker(BuildContext context) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: dateTime ?? DateTime.now(),
      firstDate: earliestAllowedDate ?? DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      updateDateTime(newDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TappableRow(
      onTap: () => _openDatePicker(context),
      title: title,
      display: dateTime == null
          ? MyText('select date...')
          : MyText(
              dateTime!.compactDateString,
              weight: FontWeight.bold,
            ),
    );
  }
}

class TimePickerDisplay extends StatelessWidget {
  final TimeOfDay? timeOfDay;
  final void Function(TimeOfDay t) updateTimeOfDay;
  final String title;
  TimePickerDisplay(
      {required this.updateTimeOfDay, this.timeOfDay, this.title = 'Time'});

  Future<void> _openTimePicker(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: timeOfDay ?? TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (newTime != null) {
      updateTimeOfDay(newTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TappableRow(
      onTap: () => _openTimePicker(context),
      title: title,
      display: timeOfDay == null
          ? MyText('select date...')
          : MyText(
              timeOfDay!.format(context),
              weight: FontWeight.bold,
            ),
    );
  }
}

class DateRangePickerDisplay extends StatelessWidget {
  final DateTime? from;
  final DateTime? to;
  final Color? textColor;
  final void Function(DateTime? from, DateTime? to) updateRange;
  DateRangePickerDisplay(
      {required this.from,
      required this.to,
      required this.updateRange,
      this.textColor});

  Future<void> _openDateRangePicker(BuildContext context) async {
    final now = DateTime.now();
    final DateTimeRange? range = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
          start: from ?? DateTime(now.year, now.month, now.day - 7),
          end: to ?? now),
      firstDate: DateTime(now.year - 10),
      lastDate: DateTime(now.year + 10),
    );
    if (range != null) {
      updateRange(range.start, range.end);
    }
  }

  Widget _text(String t) => MyText(
        t,
        size: FONTSIZE.SMALL,
        color: textColor,
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => _openDateRangePicker(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.calendar,
            color: textColor,
          ),
          SizedBox(width: 10),
          if (from == null && to == null)
            _text('All time')
          else if (from == null && to != null)
            _text('Before ${to!.compactDateString}')
          else if ((from != null && to == null))
            _text('After ${from!.compactDateString}')
          else
            _text('${from!.minimalDateString} - ${to!.minimalDateString}'),
        ],
      ),
    );
  }
}
