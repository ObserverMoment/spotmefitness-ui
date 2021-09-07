import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';

class ClosePicker extends StatelessWidget {
  final void Function() onClose;
  ClosePicker({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyText(
              'Save',
              color: Styles.infoBlue,
              size: FONTSIZE.LARGE,
              weight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
