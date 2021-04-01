import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';

/// Displays seven days of workouts and events horizontally.
/// Scrollable forward / backward in time.
class WeeklyCalendar extends StatefulWidget {
  @override
  _WeeklyCalendarState createState() => _WeeklyCalendarState();
}

class _WeeklyCalendarState extends State<WeeklyCalendar> {
  _buildDay(int index) => MyText('Day ${index.toString()}');

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => Container(
              height: 66,
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: List.generate(
                    14,
                    (index) => Container(
                          height: 50,
                          alignment: Alignment.center,
                          width: constraints.maxWidth / 7,
                          child: _buildDay(index),
                        )),
              ),
            ));
  }
}
