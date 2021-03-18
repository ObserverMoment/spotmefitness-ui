import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: 200,
        color: Styles.highlightOne,
        child: MyText('Discover'));
  }
}
