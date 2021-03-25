import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';

class ConfirmCheckIcon extends StatelessWidget {
  final double? size;
  ConfirmCheckIcon({this.size});
  @override
  Widget build(BuildContext context) {
    return Icon(CupertinoIcons.checkmark_alt,
        color: Styles.infoBlue, size: size);
  }
}
