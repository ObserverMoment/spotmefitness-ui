import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';

/// Display loading and error states for basic graphql queries which are coupled to UI widgets.
class QueryResponseBuilder extends StatelessWidget {
  final QueryResult result;
  final Widget Function() builder;
  final Widget? loadingWidget;
  QueryResponseBuilder(
      {required this.result, required this.builder, this.loadingWidget});
  @override
  Widget build(BuildContext context) {
    if (result.hasException) {
      return MyText(
        'Sorry there was a problem retrieving your info',
        color: Styles.errorRed,
      );
    } else if (result.isLoading) {
      return loadingWidget ?? LoadingCircle();
    } else {
      return FadeInUp(child: builder());
    }
  }
}
