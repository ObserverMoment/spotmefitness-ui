import 'package:artemis/artemis.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/services/store/graphql_store.dart';
import 'package:json_annotation/json_annotation.dart' as json;

/// Listens to an ObservableQuery stream of type [ObservableQueryResult<R>] and rebuilds on new data.
/// [T] is the query type.
/// [U] is the expected response type.
class QueryObserver<TData, TVars extends json.JsonSerializable>
    extends StatefulWidget {
  final Key key;
  final GraphQLQuery<TData, TVars> query;
  final QueryFetchPolicy fetchPolicy;
  final Widget Function(TData data) builder;
  final Widget? loadingIndicator;

  /// Do you want to clean up unreferenced objects from the store once this query has been fetched.
  /// Useful if the query is a list which can change every time new variables are provided.
  final bool garbageCollectAfterFetch;

  /// If true then data will be saved into the store at a key that includes details of the query variables.
  /// Defaults to false.
  final bool parameterizeQuery;

  const QueryObserver(
      {required this.key,
      required this.query,
      this.fetchPolicy = QueryFetchPolicy.storeAndNetwork,
      required this.builder,
      this.loadingIndicator,
      this.parameterizeQuery = false,
      this.garbageCollectAfterFetch = false})
      : super(key: key);

  @override
  QueryObserverState<TData, TVars> createState() =>
      QueryObserverState<TData, TVars>();
}

class QueryObserverState<TData, TVars extends json.JsonSerializable>
    extends State<QueryObserver<TData, TVars>> {
  late ObservableQuery<TData, TVars> _observableQuery;
  late GraphQLStore _store;

  void _initObservableQuery() {
    _store = context.read<GraphQLStore>();

    _observableQuery = _store.registerObserver<TData, TVars>(widget.query,
        parameterizeQuery: widget.parameterizeQuery);

    _store.fetchInitialQuery(
        id: _observableQuery.id,
        fetchPolicy: widget.fetchPolicy,
        garbageCollectAfterFetch: widget.garbageCollectAfterFetch);
  }

  @override
  void initState() {
    super.initState();
    _initObservableQuery();
  }

  @override
  void didUpdateWidget(QueryObserver<TData, TVars> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query != widget.query) {
      setState(() => _initObservableQuery());
    }
  }

  @override
  void dispose() {
    _store.unregisterObserver(_observableQuery.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GraphQLResponse>(
        initialData: _observableQuery.latest,
        stream: _observableQuery.subject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.hasErrors) {
              print(snapshot.data!.errors);
              return RetrievalErrorScreen();
            } else {
              /// [ObservableQueryResult.data] will be [TData].
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
