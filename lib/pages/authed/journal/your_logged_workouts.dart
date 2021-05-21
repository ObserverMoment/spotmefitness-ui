import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/logged_workout_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/date_time_pickers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/utils.dart';

class YourLoggedWorkoutsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserLoggedWorkouts$Query, json.JsonSerializable>(
        key: Key(
            'YourLoggedWorkoutsPage - ${UserLoggedWorkoutsQuery().operationName}'),
        query: UserLoggedWorkoutsQuery(),
        loadingIndicator: ShimmerCardList(itemCount: 10),
        builder: (data) {
          final logs = data.userLoggedWorkouts
              .sortedBy<DateTime>((l) => l.completedOn)
              .reversed
              .toList();
          return CupertinoPageScaffold(
            key: Key('YourLoggedWorkoutsPage - CupertinoPageScaffold'),
            navigationBar: BasicNavBar(
              key: Key('YourLoggedWorkoutsPage - BasicNavBar'),
              middle: NavBarTitle('Workout Logs'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CreateIconButton(
                    onPressed: () => print('open manual entry log'),
                  ),
                  InfoPopupButton(infoWidget: MyText('Info about the logs'))
                ],
              ),
            ),
            child: FilterableLoggedWorkoutsList(logs),
          );
        });
  }
}

/// TODO: When implementing filters - convert to stateful.
class FilterableLoggedWorkoutsList extends StatefulWidget {
  final List<LoggedWorkout> logs;
  FilterableLoggedWorkoutsList(this.logs);

  @override
  _FilterableLoggedWorkoutsListState createState() =>
      _FilterableLoggedWorkoutsListState();
}

class _FilterableLoggedWorkoutsListState
    extends State<FilterableLoggedWorkoutsList> {
  DateTime? _filterFrom;
  DateTime? _filterTo;

  void _openLoggedWorkoutDetails(BuildContext context, String id) {
    context.navigateTo(LoggedWorkoutDetailsRoute(id: id));
  }

  void _clearDateRange() => setState(() {
        _filterFrom = null;
        _filterTo = null;
      });

  @override
  Widget build(BuildContext context) {
    /// One day added / subtracted so as to get the range inclusively.
    final logsAfterFrom = _filterFrom == null
        ? widget.logs
        : widget.logs
            .where((l) =>
                l.completedOn.isAfter(_filterFrom!.subtract(Duration(days: 1))))
            .toList();

    final filteredLogs = _filterTo == null
        ? logsAfterFrom
        : logsAfterFrom
            .where((l) =>
                l.completedOn.isBefore(_filterTo!.add(Duration(days: 1))))
            .toList();

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(bottom: 1.0, top: 3, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    DateRangePickerDisplay(
                      from: _filterFrom,
                      to: _filterTo,
                      updateRange: (from, to) => setState(() {
                        _filterFrom = from;
                        _filterTo = to;
                      }),
                    ),
                    if (_filterFrom != null || _filterTo != null)
                      FadeIn(
                          child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: _clearDateRange,
                        child: Icon(
                          CupertinoIcons.clear_thick,
                          color: Styles.errorRed,
                        ),
                      ))
                  ],
                ),
                Row(
                  children: [
                    MyText(
                      '${filteredLogs.length} logs',
                      color: Styles.infoBlue,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    OpenTextSearchButton(
                      onPressed: () => context.push(
                          fullscreenDialog: true,
                          child: YourLoggedWorkoutsTextSearch(
                              allLoggedWorkouts: widget.logs,
                              selectLoggedWorkout: (l) =>
                                  _openLoggedWorkoutDetails(context, l.id))),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredLogs.length,
                itemBuilder: (c, i) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                          onTap: () => _openLoggedWorkoutDetails(
                              context, filteredLogs[i].id),
                          child: LoggedWorkoutCard(filteredLogs[i])),
                    )),
          )
        ],
      ),
    );
  }
}

class YourLoggedWorkoutsTextSearch extends StatefulWidget {
  final List<LoggedWorkout> allLoggedWorkouts;
  final void Function(LoggedWorkout loggedWorkout) selectLoggedWorkout;

  YourLoggedWorkoutsTextSearch(
      {required this.allLoggedWorkouts, required this.selectLoggedWorkout});

  @override
  _YourLoggedWorkoutsTextSearchState createState() =>
      _YourLoggedWorkoutsTextSearchState();
}

class _YourLoggedWorkoutsTextSearchState
    extends State<YourLoggedWorkoutsTextSearch> {
  String _searchString = '';
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  bool _filter(LoggedWorkout log) {
    return log.name.toLowerCase().contains(_searchString);
  }

  List<LoggedWorkout> _filterBySearchString() {
    return Utils.textNotNull(_searchString)
        ? widget.allLoggedWorkouts.where((m) => _filter(m)).toList()
        : [];
  }

  void _handleSelectLoggedWorkout(LoggedWorkout loggedWorkout) {
    widget.selectLoggedWorkout(loggedWorkout);
    context.pop();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredLogs = _filterBySearchString();
    return CupertinoPageScaffold(
      navigationBar: BasicNavBar(
        middle: NavBarTitle('Search Your Logs'),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: CupertinoSearchTextField(
                      focusNode: _focusNode,
                      onChanged: (value) =>
                          setState(() => _searchString = value.toLowerCase()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FadeIn(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  children: filteredLogs
                      .sortedBy<DateTime>((log) => log.completedOn)
                      .reversed
                      .map((log) => GestureDetector(
                          onTap: () => _handleSelectLoggedWorkout(log),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4.0),
                            child: LoggedWorkoutCard(log),
                          )))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
