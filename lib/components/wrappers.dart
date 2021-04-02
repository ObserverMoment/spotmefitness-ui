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
      print(result.exception);
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: NavBarTitle('Oops...'),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: MyText(
            'Sorry there was a problem retrieving your info',
            color: Styles.errorRed,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
      );
    } else if (result.isLoading) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: NavBarTitle('Loading...'),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: loadingWidget ?? LoadingCircle(),
          ),
        ),
      );
    } else {
      return FadeIn(child: builder());
    }
  }
}
