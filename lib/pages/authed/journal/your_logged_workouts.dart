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
import 'package:spotmefitness_ui/constants.dart';
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
    final query =
        UserLoggedWorkoutsQuery(variables: UserLoggedWorkoutsArguments());
    return QueryObserver<UserLoggedWorkouts$Query, json.JsonSerializable>(
        key: Key('YourLoggedWorkoutsPage - ${query.operationName}'),
        query: query,
        loadingIndicator: ShimmerCardList(itemCount: 10),
        builder: (data) {
          final logs = data.userLoggedWorkouts
              .sortedBy<DateTime>((l) => l.completedOn)
              .reversed
              .toList();

          return CupertinoPageScaffold(
            key: Key('YourLoggedWorkoutsPage - CupertinoPageScaffold'),
            navigationBar: BasicNavBar(
              heroTag: 'YourLoggedWorkoutsPage',
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

  List<Widget> _floatingButtons(int numLogs) => [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
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
                    size: 20,
                  ),
                ))
            ],
          ),
        ),
        CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            onPressed: () => context.push(
                fullscreenDialog: true,
                child: YourLoggedWorkoutsTextSearch(
                    allLoggedWorkouts: widget.logs,
                    selectLoggedWorkout: (l) =>
                        _openLoggedWorkoutDetails(context, l.id))),
            child: Icon(
              CupertinoIcons.search,
            ))
      ];

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

    final buttons = _floatingButtons(filteredLogs.length);

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        filteredLogs.isEmpty
            ? Center(child: MyText('No logs to display...'))
            : Column(
                children: [
                  if (_filterFrom != null || _filterTo != null)
                    FadeIn(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MyText(
                              '${filteredLogs.length} logs',
                              size: FONTSIZE.SMALL,
                            ),
                          ],
                        ),
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredLogs.length + 1,
                          itemBuilder: (c, i) {
                            if (i == filteredLogs.length) {
                              return SizedBox(height: 60);
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                    onTap: () => _openLoggedWorkoutDetails(
                                        context, filteredLogs[i].id),
                                    child: LoggedWorkoutCard(filteredLogs[i])),
                              );
                            }
                          }),
                    ),
                  ),
                ],
              ),
        Positioned(
            bottom: kBottomNavBarHeight + 10,
            child: RaisedButtonContainer(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
              child: SizedBox(
                height: 40,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (c, i) => buttons[i],
                    separatorBuilder: (c, i) => ButtonSeparator(),
                    itemCount: buttons.length),
              ),
            ))
      ],
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
        heroTag: 'YourLoggedWorkoutsTextSearch',
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