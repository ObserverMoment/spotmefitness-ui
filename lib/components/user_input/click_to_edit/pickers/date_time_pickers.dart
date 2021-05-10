import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart' as myTheme;
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/tappable_row.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

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
    secondary: theme.primary,
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
  return Theme(
      data: base.copyWith(
        colorScheme: _buildColorScheme(context),
        primaryColor: context.theme.primary, //Head background
        accentColor: context.theme.primary, //Selection color
        dialogBackgroundColor: context.theme.cardBackground,
        textTheme: _buildShrineTextTheme(context, base.textTheme),
      ),
      child: child);
}

class DatePickerDisplay extends StatelessWidget {
  final DateTime? dateTime;
  final void Function(DateTime d) updateDateTime;
  final DateTime? earliestAllowedDate;
  DatePickerDisplay(
      {required this.updateDateTime, this.dateTime, this.earliestAllowedDate});

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
      title: 'Date',
      display: dateTime == null
          ? MyText('select date...')
          : MyText(
              DateFormat.MMMMd().format(dateTime!),
              weight: FontWeight.bold,
            ),
    );
  }
}

class TimePickerDisplay extends StatelessWidget {
  final TimeOfDay? timeOfDay;
  final void Function(TimeOfDay t) updateTimeOfDay;
  TimePickerDisplay({required this.updateTimeOfDay, this.timeOfDay});

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
      title: 'Time',
      display: timeOfDay == null
          ? MyText('select date...')
          : MyText(
              timeOfDay!.format(context),
              weight: FontWeight.bold,
            ),
    );
  }
}
