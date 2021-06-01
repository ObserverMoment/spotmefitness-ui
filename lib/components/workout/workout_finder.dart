import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:spotmefitness_ui/blocs/text_search_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/workout_card.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/menus/context_menu.dart';
import 'package:spotmefitness_ui/components/user_input/text_search_field.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/services/text_search_filters.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:substring_highlight/substring_highlight.dart';
import 'package:async/async.dart';

/// Widget that uses filters to find and select a workout.
class WorkoutFinderPage extends StatefulWidget {
  final void Function(Workout workout) selectWorkout;
  WorkoutFinderPage(this.selectWorkout);

  @override
  _WorkoutFinderPageState createState() => _WorkoutFinderPageState();
}

class _WorkoutFinderPageState extends State<WorkoutFinderPage> {
  final kIconSize = 28.0;
  final kCollapsedpanelheight = 66.0;
  final PanelController _panelController = PanelController();
  bool _panelIsOpen = false;

  void _togglePanel() {
    if (_panelIsOpen) {
      _panelIsOpen = false;
      _panelController.close();
    } else {
      _panelIsOpen = true;
      _panelController.open();
    }
  }

  /// Pops itself (and any stack items such as the text seach widget)
  /// Then passes the selected workout to the parent.
  void _selectWorkout(Workout workout) {
    context.router.popUntilRoot();
    widget.selectWorkout(workout);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return QueryObserver<UserWorkouts$Query, json.JsonSerializable>(
        key: Key('WorkoutFinderPage - ${UserWorkoutsQuery().operationName}'),
        query: UserWorkoutsQuery(),
        loadingIndicator: CupertinoPageScaffold(
            navigationBar: BorderlessNavBar(
              middle: NavBarTitle('Getting Ready...'),
            ),
            child: ShimmerCardList(itemCount: 20)),
        builder: (data) {
          final userWorkouts = data.userWorkouts
              .sortedBy<DateTime>((w) => w.createdAt!)
              .reversed
              .toList();

          return CupertinoPageScaffold(
              child: SafeArea(
            child: SlidingUpPanel(
              color: context.theme.cardBackground,
              controller: _panelController,
              border: Border.all(color: context.theme.primary.withOpacity(0.1)),
              minHeight: kCollapsedpanelheight,
              maxHeight: size.height,
              borderRadius: BorderRadius.circular(20),
              margin: const EdgeInsets.all(6),
              panel: Column(
                children: [
                  GestureDetector(
                    onTap: _togglePanel,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: kCollapsedpanelheight,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText('No active filters'),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MyText('Filters', weight: FontWeight.bold),
                                SizedBox(width: 8),
                                Transform.rotate(
                                  angle: -pi / 2,
                                  child: Icon(
                                    CupertinoIcons.slider_horizontal_3,
                                  ),
                                )
                              ],
                            ),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FilterTabIcon(
                            icon: Icon(
                              CupertinoIcons.info_circle_fill,
                              size: kIconSize,
                            ),
                            label: 'Meta',
                            onTap: () => print(0)),
                        FilterTabIcon(
                            icon: SvgPicture.asset(
                              'assets/workout_filters_icons/filter_equipment_icon.svg',
                              height: kIconSize,
                              width: kIconSize,
                              color: context.theme.primary,
                            ),
                            label: 'Equipment',
                            onTap: () => print(1)),
                        FilterTabIcon(
                            icon: SvgPicture.asset(
                                'assets/workout_filters_icons/filter_body_icon.svg',
                                height: kIconSize,
                                width: kIconSize,
                                color: context.theme.primary),
                            label: 'Body',
                            onTap: () => print(2)),
                        FilterTabIcon(
                            icon: SvgPicture.asset(
                                'assets/workout_filters_icons/filter_moves_icon.svg',
                                height: kIconSize,
                                width: kIconSize,
                                color: context.theme.primary),
                            label: 'Moves',
                            onTap: () => print(3)),
                      ],
                    ),
                  ),
                ],
              ),
              body: CupertinoPageScaffold(
                navigationBar: BorderlessNavBar(
                  middle: NavBarTitle('Find a Workout'),
                  trailing: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => context.push(
                        fullscreenDialog: true,
                        child: WorkoutFinderTextSearch(
                            userWorkouts: userWorkouts,
                            selectWorkout: _selectWorkout)),
                    child: Icon(
                      CupertinoIcons.search,
                      size: 25,
                    ),
                  ),
                ),
                child: WorkoutFinderFilteredWorkouts(
                  selectWorkout: _selectWorkout,
                  workouts: userWorkouts,
                ),
              ),
            ),
          ));
        });
  }
}

class WorkoutFinderTextSearch extends StatefulWidget {
  final List<Workout> userWorkouts;
  final void Function(Workout workout) selectWorkout;

  WorkoutFinderTextSearch(
      {required this.userWorkouts, required this.selectWorkout});

  @override
  _WorkoutFinderTextSearchState createState() =>
      _WorkoutFinderTextSearchState();
}

class _WorkoutFinderTextSearchState extends State<WorkoutFinderTextSearch> {
  String _searchString = '';
  late FocusNode _focusNode;
  int _activePageIndex = 0;
  PageController _pageController = PageController();
  List<Workout> _filteredUserWorkouts = [];

  /// Handles retrieving full workout objects from the API when the user presses submit (search) on the keyboard.
  late TextSearchBloc<Workout> _workoutsTextSearchBloc;

  /// Handles retrieving just workout names (similar to a suggestions list) as the user is typing their search query.
  late TextSearchBloc<TextSearchResult> _workoutNamesTextSearchBloc;

  @override
  void initState() {
    super.initState();
    _workoutsTextSearchBloc =
        TextSearchBloc<Workout>(context, TextSearchType.workout);
    _workoutNamesTextSearchBloc =
        TextSearchBloc<TextSearchResult>(context, TextSearchType.workoutName);

    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  void _updatePageIndex(int index) {
    setState(() => _activePageIndex = index);
    _pageController.jumpToPage(_activePageIndex);
    _handleSearchStringUpdate(_searchString);
  }

  /// Similar functionality to Apple Podcasts.
  /// Two responses.
  /// 1. For users own workouts data is all client side so updates happen immediately on user input. Results displayed as cards.
  /// 2 For public workouts. Search the API for workouts based on the search string.
  /// While user is typing a list of workout titles (only) will display.
  void _handleSearchStringUpdate(String text) {
    setState(() => _searchString = text.toLowerCase());
    if (_searchString.length > 2) {
      if (_activePageIndex == 0) {
        setState(() {
          _filteredUserWorkouts = TextSearchFilters.workoutsBySearchString(
              widget.userWorkouts, _searchString);
        });
      } else if (_activePageIndex == 1) {
        // Clear the previous Workout list search results. We revert now to text list while user is inputting text.
        _workoutsTextSearchBloc.clear(gotoState: TextSearchState.loading);

        /// Call the api (debounced) and return a list of workout titles that match.
        _workoutNamesTextSearchBloc.search(_searchString);
      }
    }
  }

  /// 1. Private. Submitting search on keyboard has no effect. Updates happen immediately / incrementally.
  /// 2. Public. When user clicks submit on keyboard a full search will happen on the API, returning full workout objects displayed as cards.
  void _handleSearchSubmit(String text) {
    print(text);

    /// Only run if user is searching public workouts. Otherwise do nothing.
    if (_activePageIndex == 1) {
      // Clear the text lists data so that when workout list data is returned is can be displayed.
      // Text name list data will always display if it is not empty.
      _workoutNamesTextSearchBloc.clear(gotoState: TextSearchState.loading);
      // handle the full api search (debounced) and return a list of full workouts that match.
      _workoutsTextSearchBloc.search(text.toLowerCase());
    }
  }

  @override
  void dispose() {
    _workoutsTextSearchBloc.dispose();
    _workoutNamesTextSearchBloc.dispose();
    _focusNode.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: MyCupertinoSearchTextField(
                      placeholder: _activePageIndex == 0
                          ? 'Search your workouts'
                          : 'Search all workouts',
                      focusNode: _focusNode,
                      onChanged: _handleSearchStringUpdate,
                      onSubmitted: _handleSearchSubmit,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                NavBarCloseButton(context.pop),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
            child: SizedBox(
              width: double.infinity,
              child: SlidingSelect<int>(
                  value: _activePageIndex,
                  updateValue: _updatePageIndex,
                  children: {
                    0: MyText('Your Workouts'),
                    1: MyText('All Workouts'),
                  }),
            ),
          ),
          Expanded(
              child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              _searchString.length > 2
                  ? _filteredUserWorkouts.isEmpty
                      ? Center(
                          child: MyText(
                          'No results.',
                          subtext: true,
                        ))
                      : WorkoutFinderFilteredWorkouts(
                          selectWorkout: widget.selectWorkout,
                          workouts: _filteredUserWorkouts)
                  : Center(
                      child: MyText(
                      'Enter at least 3 characters.',
                      subtext: true,
                    )),
              _searchString.length > 2
                  ? StreamBuilder<TextSearchState>(
                      initialData: TextSearchState.empty,
                      stream: StreamGroup.merge([
                        _workoutsTextSearchBloc.state,
                        _workoutNamesTextSearchBloc.state
                      ]),
                      builder: (context, stateSnapshot) {
                        return StreamBuilder<List<Workout>>(
                            initialData: <Workout>[],
                            stream: _workoutsTextSearchBloc.results,
                            builder: (context, workoutsSnapshot) {
                              return StreamBuilder<List<TextSearchResult>>(
                                  initialData: <TextSearchResult>[],
                                  stream: _workoutNamesTextSearchBloc.results,
                                  builder: (context, workoutNamesSnapshot) {
                                    // Handle state.
                                    if (stateSnapshot.data ==
                                        TextSearchState.error) {
                                      return Center(
                                        child: MyText(
                                          'Sorry, there was a problem getting results',
                                          color: Styles.errorRed,
                                        ),
                                      );
                                    } else if (stateSnapshot.data ==
                                        TextSearchState.loading) {
                                      return Center(child: LoadingCircle());
                                    } else if (stateSnapshot.data ==
                                        TextSearchState.empty) {
                                      // Or show placeholder message.
                                      return Center(
                                          child: MyText(
                                        'Enter at least 3 characters.',
                                        subtext: true,
                                      ));
                                    } else {
                                      // Handle data
                                      // Always show names list if it is not empty
                                      if (workoutNamesSnapshot
                                          .data!.isNotEmpty) {
                                        return FadeIn(
                                          child: WorkoutFinderTextResultsNames(
                                            results: workoutNamesSnapshot.data!,
                                            searchString: _searchString,
                                            searchWorkoutName:
                                                _handleSearchSubmit,
                                          ),
                                        );
                                      } else if (workoutsSnapshot
                                          .data!.isNotEmpty) {
                                        // Or show workouts list if not empty.
                                        return FadeIn(
                                          child: WorkoutFinderFilteredWorkouts(
                                            workouts: workoutsSnapshot.data!,
                                            selectWorkout: widget.selectWorkout,
                                          ),
                                        );
                                      } else {
                                        // Or show empty results message.
                                        return Center(
                                            child: MyText(
                                          'No results....',
                                          subtext: true,
                                        ));
                                      }
                                    }
                                  });
                            });
                      })
                  : Center(
                      child: MyText(
                      'Enter at least 3 characters.',
                      subtext: true,
                    )),
            ],
          )),
        ]),
      ),
    );
  }
}

/// Text only list of names being returned from the api based on the user input.
/// On press of the text result we set the search string to the exact name of the search string and then run a text search returning full workout objects.
class WorkoutFinderTextResultsNames extends StatelessWidget {
  final List<TextSearchResult> results;
  final String searchString;
  final void Function(String name) searchWorkoutName;
  WorkoutFinderTextResultsNames(
      {required this.results,
      required this.searchString,
      required this.searchWorkoutName});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: results.length,
        itemBuilder: (c, i) => GestureDetector(
              onTap: () => searchWorkoutName(results[i].name),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: context.theme.primary.withOpacity(0.15),
                  ))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.search,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      SubstringHighlight(
                          textStyle: TextStyle(
                              fontSize: 16,
                              color: context.theme.primary.withOpacity(0.7)),
                          textStyleHighlight: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Styles.infoBlue),
                          text: results[i].name,
                          term: searchString),
                    ],
                  ),
                ),
              ),
            ));
  }
}

class WorkoutFinderFilteredWorkouts extends StatelessWidget {
  final List<Workout> workouts;
  final void Function(Workout workout) selectWorkout;
  WorkoutFinderFilteredWorkouts(
      {required this.workouts, required this.selectWorkout});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: workouts.length,
      itemBuilder: (c, i) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: ContextMenu(
          key: Key('workoutcard $i'),
          child: WorkoutCard(workouts[i]),
          menuChild: WorkoutCard(
            workouts[i],
            showEquipment: false,
            showMoves: false,
          ),
          actions: [
            ContextMenuAction(
                text: 'Select',
                iconData: CupertinoIcons.add,
                onTap: () => selectWorkout(workouts[i])),
            ContextMenuAction(
                text: 'View',
                iconData: CupertinoIcons.eye,
                onTap: () => context
                    .navigateTo(WorkoutDetailsRoute(id: workouts[i].id))),
          ],
        ),
      ),
    );
  }
}

class FilterTabIcon extends StatelessWidget {
  final Widget icon;
  final String label;
  final void Function() onTap;
  FilterTabIcon({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [icon, MyText(label, size: FONTSIZE.TINY)],
        ),
      ),
    );
  }
}
