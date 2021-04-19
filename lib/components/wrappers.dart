import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';

/// Wraps flutter_graphql [Query] widget, handles error states in a consistent way.
/// Then uses the returned result to build the screen via builder.
class QueryResponseBuilder extends StatelessWidget {
  final QueryOptions options;
  final Widget Function(QueryResult,
      {Future<QueryResult> Function(FetchMoreOptions)? fetchMore,
      Future<QueryResult?> Function()? refetch}) builder;
  final Widget? loadingWidget;
  QueryResponseBuilder(
      {required this.options, required this.builder, this.loadingWidget});
  @override
  Widget build(BuildContext context) {
    return Query(
      options: options,
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          print(result.exception);
          return CupertinoPageScaffold(
            navigationBar: BasicNavBar(
              middle: NavBarTitle('Oops...'),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: MyText(
                    'Sorry there was a problem retrieving your info',
                    color: Styles.errorRed,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          );
        } else if (result.isLoading) {
          return SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: loadingWidget ?? LoadingCircle(),
              ),
            ),
          );
        } else {
          return FadeIn(
              child: builder(result, fetchMore: fetchMore, refetch: refetch));
        }
      },
    );
  }
}

/// Wrapper around [FutureBuilder] which handles loading an error states in a consistent way across the application.
class FutureBuilderHandler<T> extends StatelessWidget {
  final Widget? loadingWidget;
  final Future<T> future;
  final Widget Function(T data) builder;
  FutureBuilderHandler(
      {required this.future, required this.builder, this.loadingWidget});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return CupertinoPageScaffold(
            navigationBar: BasicNavBar(
              middle: NavBarTitle('Oops...'),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: MyText(
                    'Sorry there was a problem setting up this screen',
                    color: Styles.errorRed,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          );
        } else if (!snapshot.hasData) {
          return loadingWidget ??
              SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: LoadingCircle(),
                  ),
                ),
              );
        } else {
          return builder(snapshot.data!);
        }
      },
    );
  }
}
