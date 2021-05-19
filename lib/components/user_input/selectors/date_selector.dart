import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class DateSelector extends StatefulWidget {
  final void Function(DateTime date) saveDate;
  final DateTime? selectedDate;
  final DateTime? initialDate;
  DateSelector({required this.saveDate, this.selectedDate, this.initialDate});
  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? widget.selectedDate ?? DateTime.now();
  }

  void _handleDateTimeChange(DateTime date) =>
      setState(() => _selectedDate = date);

  void _handleSave() {
    if (_selectedDate != null) {
      widget.saveDate(_selectedDate!);
    }
    context.pop();
  }

  void _handleCancel() => context.pop();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: BasicNavBar(
        customLeading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _handleCancel,
          child: MyText(
            'Cancel',
            color: Styles.errorRed,
          ),
        ),
        middle: NavBarTitle('Select Date'),
        trailing: _selectedDate != null
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _handleSave,
                child: MyText(
                  'Save',
                  color: Styles.infoBlue,
                ),
              )
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 400,
              child: CupertinoDatePicker(
                  initialDateTime: _selectedDate,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: _handleDateTimeChange))
        ],
      ),
    );
  }
}
