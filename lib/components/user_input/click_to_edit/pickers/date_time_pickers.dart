import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart' as myTheme;
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

TextTheme _buildShrineTextTheme(BuildContext context, TextTheme base) {
  return base.copyWith(
    // Selected date in header.
    headline4: GoogleFonts.palanquin(textStyle: TextStyle(fontSize: 30)),
    // Month picker dropdown.
    subtitle2: GoogleFonts.palanquin(),
    // Days and dates.
    caption:
        GoogleFonts.palanquin(textStyle: TextStyle(fontSize: 18, height: 1)),
  );
}

ColorScheme _buildColorScheme(BuildContext context) {
  final theme = context.theme;
  return ColorScheme(
    primary: theme.primary,
    primaryVariant: theme.primary,
    secondary: theme.cardBackground,
    secondaryVariant: theme.primary,
    surface: theme.cardBackground,
    background: theme.cardBackground,
    error: myTheme.Styles.errorRed,
    onPrimary: theme.background,
    onSecondary: theme.primary,
    onSurface: theme.primary,
    onBackground: theme.primary,
    onError: myTheme.Styles.white,
    brightness: theme.brightness,
  );
}

Widget _buildDateTimePickerTheme(BuildContext context, Widget child) {
  final ThemeData base = context.theme.themeName == myTheme.ThemeName.dark
      ? ThemeData.dark()
      : ThemeData.light();
  final theme = context.theme;
  return Theme(
      data: base.copyWith(
        colorScheme: _buildColorScheme(context),
        appBarTheme: base.appBarTheme.copyWith(
            backgroundColor:
                theme.cardBackground), // Header background of range picker.
        primaryColor: theme.primary, // Head of Date Picker background
        accentColor: theme.primary, // Selection color for date picker
        dialogBackgroundColor: theme.cardBackground,
        scaffoldBackgroundColor:
            theme.cardBackground, // Main background of range picker.
        textTheme: _buildShrineTextTheme(context, base.textTheme),
      ),
      child: child);
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
      builder: (context, child) {
        return _buildDateTimePickerTheme(context, child!);
      },
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
      builder: (context, child) {
        return _buildDateTimePickerTheme(context, child!);
      },
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
  final void Function(DateTime? from, DateTime? to) updateRange;
  DateRangePickerDisplay(
      {required this.from, required this.to, required this.updateRange});

  Future<void> _openDateRangePicker(BuildContext context) async {
    final now = DateTime.now();
    final DateTimeRange? range = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
          start: from ?? DateTime(now.year, now.month, now.day - 7),
          end: to ?? now),
      firstDate: DateTime(now.year - 10),
      lastDate: DateTime(now.year + 10),
      builder: (context, child) {
        return _buildDateTimePickerTheme(context, child!);
      },
    );
    if (range != null) {
      updateRange(range.start, range.end);
    }
  }

  Widget _text(String t) =>
      MyText(t, size: FONTSIZE.SMALL, weight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => _openDateRangePicker(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.calendar),
          SizedBox(width: 6),
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
