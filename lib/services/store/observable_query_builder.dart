import 'package:artemis/artemis.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';

/// Listens to an ObservableQuery stream of type [ObservableQueryResult<T>] and rebuilds on new data.
class ObservableQueryBuilder extends StatefulWidget {
  final Key key;
  final GraphQLQuery query;
  final QueryFetchPolicy fetchPolicy;
  final Widget Function(GraphQLResponse res) builder;
  final Widget? loadingIndicator;

  const ObservableQueryBuilder({
    required this.key,
    required this.query,
    this.fetchPolicy = QueryFetchPolicy.storeAndNetwork,
    required this.builder,
    this.loadingIndicator,
  }) : super(key: key);

  @override
  ObservableQueryBuilderState createState() => ObservableQueryBuilderState();
}

class ObservableQueryBuilderState extends State<ObservableQueryBuilder> {
  late ObservableQuery _observableQuery;
  late GraphQLStore _store;

  @override
  void initState() {
    super.initState();
    _store = context.read<GraphQLStore>();
    _observableQuery = _store.registerObservableQuery(widget.query);
    _store.fetchQuery(widget.query.operationName!, widget.fetchPolicy);
  }

  @override
  void dispose() {
    _store.unregisterObservableQuery(widget.query.operationName!);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ObservableQueryResult>(
        initialData: _observableQuery.latest ?? ObservableQueryResult.loading(),
        stream: _observableQuery.subject.stream,
        builder: (
          BuildContext buildContext,
          AsyncSnapshot<ObservableQueryResult> snapshot,
        ) {
          print('new snapshot');
          if (snapshot.hasError) {
            print('snapshot.hasError');
            print(snapshot.error);
            return RetrievalErrorScreen();
          } else if (snapshot.hasData) {
            print('snapshot.hasData');
            print(snapshot.data!);
            print('snapshot.data!.data');
            print(snapshot.data!.data);
            print(snapshot.data!.state);
            print(snapshot.data!.state);
            if (snapshot.data!.hasException) {
              print('snapshot.data!.exception');
              print(snapshot.data!.exception);
              return RetrievalErrorScreen();
            } else if (snapshot.data!.isLoading) {
              print('snapshot.data!.isLoading');
              return widget.loadingIndicator ?? Center(child: LoadingCircle());
            } else {
              print('snapshot.data!.data!');
              print(snapshot.data!.data!);
              return widget.builder(snapshot.data!.data!);
            }
          } else {
            return widget.loadingIndicator ?? Center(child: LoadingCircle());
          }
        });
  }
}

class RetrievalErrorScreen extends StatelessWidget {
  final String? message;
  RetrievalErrorScreen({this.message});
  @override
  Widget build(BuildContext context) {
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
              message ?? 'Sorry there was a problem retrieving your info',
              color: Styles.errorRed,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
