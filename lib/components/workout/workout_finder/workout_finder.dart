import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sofie_ui/components/animated/animated_rotation.dart';
import 'package:sofie_ui/components/animated/loading_shimmers.dart';
import 'package:sofie_ui/components/animated/mounting.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/indicators.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/user_input/filters/blocs/workout_filters_bloc.dart';
import 'package:sofie_ui/components/user_input/filters/screens/workout_filters_screen/workout_filters_screen.dart';
import 'package:sofie_ui/components/user_input/pickers/sliding_select.dart';
import 'package:sofie_ui/components/workout/workout_finder/filtered_workouts_list.dart';
import 'package:sofie_ui/components/workout/workout_finder/workout_finder_text_search.dart';
import 'package:sofie_ui/components/workout/workout_finder/workout_finder_workout_card.dart';
import 'package:sofie_ui/constants.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/router.gr.dart';
import 'package:sofie_ui/services/store/query_observer.dart';

/// Widget that uses filters to find and select a workout.
/// Wrapper around the UI which handles the [ObservableQuery]s [UserWorkouts] and [UserCollections]
/// Client side the user can filter their created workouts and their saved workouts. Via the api their can filter public workouts.
class WorkoutFinderPage extends StatelessWidget {
  final void Function(Workout workout)? selectWorkout;

  /// Rather than 'your workouts' - users client side plans list.
  /// https://github.com/Milad-Akarie/auto_route_library/issues/404
  /// Re [initialOpenPublicTab]: nullable route args.
  final bool? initialOpenPublicTab;
  const WorkoutFinderPage(
      {Key? key, this.selectWorkout, this.initialOpenPublicTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryObserver<UserWorkouts$Query, json.JsonSerializable>(
        key: Key('WorkoutFinderPage - ${UserWorkoutsQuery().operationName}'),
        query: UserWorkoutsQuery(),
        loadingIndicator: const ShimmerListPage(
          cardHeight: 220,
        ),
        builder: (createdWorkoutsData) {
          return QueryObserver<UserCollections$Query, json.JsonSerializable>(
              key: Key(
                  'WorkoutFinderPage - ${UserCollectionsQuery().operationName}'),
              query: UserCollectionsQuery(),
              loadingIndicator: const ShimmerListPage(
                cardHeight: 220,
              ),
              builder: (collectionsData) {
                final userWorkouts = createdWorkoutsData.userWorkouts;

                final savedWorkouts = collectionsData.userCollections
                    .fold<List<Workout>>(
                        [], (acum, next) => [...acum, ...next.workouts]);

                return WorkoutFinderPageUI(
                  selectWorkout: selectWorkout,
                  initialOpenPublicTab: initialOpenPublicTab ?? false,
                  userWorkouts: [...userWorkouts, ...savedWorkouts]
                      .reversed
                      .toSet()
                      .toList(),
                );
              });
        });
  }
}

class WorkoutFinderPageUI extends StatefulWidget {
  final List<Workout> userWorkouts;

  /// Rather than 'your workouts' - users client side plans list.
  final bool initialOpenPublicTab;
  final void Function(Workout workout)? selectWorkout;
  const WorkoutFinderPageUI({
    Key? key,
    required this.userWorkouts,
    this.selectWorkout,
    this.initialOpenPublicTab = false,
  }) : super(key: key);

  @override
  _WorkoutFinderPageUIState createState() => _WorkoutFinderPageUIState();
}

class _WorkoutFinderPageUIState extends State<WorkoutFinderPageUI> {
  final kCollapsedpanelheight = 80.0;

  /// Doesn't appear to require disposing.
  final PanelController _panelController = PanelController();
  bool _panelIsOpen = false;

  /// 0 is your workouts, 1 is public workouts.
  late int _activePageIndex;

  late WorkoutFiltersBloc _bloc;
  late WorkoutFilters _lastUsedFilters;

  /// Manages client side list and scrolling.
  List<Workout> _filteredUserWorkouts = [];
  final ScrollController _userWorkoutsListScrollController = ScrollController();

  /// For inifinite scroll / pagination of public workouts from the network.
  static const kfilterResultsPageSize = 15;

  /// Cursor for public workouts pagination. The id of the last retrieved workout.
  String? _cursor;

  /// Adjust the scroll position when refreshing this list.
  final ScrollController _pagingScrollController = ScrollController();
  final PagingController<int, Workout> _pagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 10);

  void _updateLastUsedFilters() {
    _lastUsedFilters = WorkoutFilters.fromJson(_bloc.filters.json);
  }

  @override
  void initState() {
    super.initState();

    _activePageIndex = widget.initialOpenPublicTab ? 1 : 0;

    _bloc = context.read<WorkoutFiltersBloc>();
    _updateLastUsedFilters();

    _filteredUserWorkouts = _bloc.filterYourWorkouts(widget.userWorkouts);

    /// [nextPageKey] will be zero when the filters are refreshed. This means no cursor should be passed.
    /// Any other number for the pageKey causes this function to look up the [_cursor] from state.
    /// To standardize, we pass pageKey as [1] whenever a page is appended to the list.
    _pagingController.addPageRequestListener((nextPageKey) {
      _fetchPublicWorkouts(nextPageKey);
    });
  }

  Future<List<Workout>> _executePublicWorkoutsQuery({String? cursor}) async {
    final variables = PublicWorkoutsArguments(
        take: kfilterResultsPageSize,
        cursor: cursor,
        filters: WorkoutFiltersInput.fromJson(_bloc.filters.apiJson));

    final query = PublicWorkoutsQuery(variables: variables);
    final response = await context.graphQLStore.execute(query);

    if ((response.errors != null && response.errors!.isNotEmpty) ||
        response.data == null) {
      throw Exception(
          'Sorry, something went wrong!: ${response.errors != null ? response.errors!.join(',') : ''}');
    }

    return query.parse(response.data ?? {}).publicWorkouts;
  }

  Future<void> _fetchPublicWorkouts(int nextPageKey) async {
    try {
      /// [nextPageKey] aka cursor defaults to 0 when [_pagingController] is initialised.
      final workouts = await _executePublicWorkoutsQuery(
          cursor: nextPageKey == 0 ? null : _cursor);

      final isLastPage = workouts.length < kfilterResultsPageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(workouts);
      } else {
        _cursor = workouts.last.id;

        /// Pass nextPageKey as 1. Acts like a boolean to tell future fetch calls to get the _[cursor] from local state.
        _pagingController.appendPage(workouts, 1);
      }
    } catch (error) {
      if (mounted) _pagingController.error = error;
    }

    /// If [nextPageKey == 0] then this is a fresh set of filters / results triggered by [paginationController.refresh()]. Padding on the bottom of the [PagedListView] which pushes it up over the collapsed sliding panel at the bottom of the page was causing new results to emerge scrolled down by the same value as vertical padding. May be a bug in the package but this has resolved it.
    if (nextPageKey == 0) {
      _resetScrollPosition(_pagingScrollController);
    }
    setState(() {});
  }

  Future<void> _clearAllFilters() async {
    await _bloc.clearAllFilters();
    _pagingController.refresh();

    /// Reset the user workouts list scroll position.
    _resetScrollPosition(_userWorkoutsListScrollController);
    setState(() {
      _updateLastUsedFilters();
      _filteredUserWorkouts = [...widget.userWorkouts];
    });
  }

  void _updatePageIndex(int index) {
    setState(() => _activePageIndex = index);
  }

  void _togglePanel() {
    if (_panelIsOpen) {
      _panelIsOpen = false;
      _panelController.close();
    } else {
      _panelIsOpen = true;
      _panelController.open();
    }
  }

  void _handlePanelClose() {
    if (_bloc.filtersHaveChanged(_lastUsedFilters)) {
      _updateLastUsedFilters();
      _pagingController.refresh();
      _filteredUserWorkouts = _bloc.filterYourWorkouts(widget.userWorkouts);
      _resetScrollPosition(_userWorkoutsListScrollController);
    }
    setState(() => _panelIsOpen = false);
  }

  void _handlePanelOpen() {
    setState(() => _panelIsOpen = true);
  }

  void _resetScrollPosition(ScrollController controller) {
    if (controller.hasClients) {
      controller.animateTo(0,
          duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
    }
  }

  /// Pops itself (and any stack items such as the text seach widget)
  /// Then passes the selected workout to the parent.
  void _selectWorkout(Workout workout) {
    if (widget.selectWorkout != null) {
      // If open - pop the text search route.
      context.router.popUntilRouteWithName(WorkoutFinderRoute.name);
      // Then pop itself.
      context.pop();
      widget.selectWorkout!(workout);
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _pagingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final safePaddingTop = mediaQuery.padding.top;

    final numActiveFilters =
        context.select<WorkoutFiltersBloc, int>((b) => b.numActiveFilters);

    return CupertinoPageScaffold(
        child: SlidingUpPanel(
      color: context.theme.background,
      controller: _panelController,
      onPanelClosed: _handlePanelClose,
      onPanelOpened: _handlePanelOpen,
      minHeight: kCollapsedpanelheight,
      maxHeight: size.height - safePaddingTop,
      borderRadius: BorderRadius.circular(12),
      panel: Column(
        children: [
          GestureDetector(
            onTap: _togglePanel,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: kCollapsedpanelheight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyAnimatedRotation(
                          rotate: _panelIsOpen,
                          child: const Icon(
                            CupertinoIcons.chevron_up,
                          )),
                      AnimatedSwitcher(
                        duration: kStandardAnimationDuration,
                        child: numActiveFilters > 0
                            ? TextButton(
                                text: 'Clear Filters',
                                prefix: const Icon(
                                  CupertinoIcons.clear_thick,
                                  size: 16,
                                ),
                                underline: false,
                                onPressed: _clearAllFilters)
                            : const MyText(
                                'No active filters',
                                subtext: true,
                              ),
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Icon(
                                CupertinoIcons.slider_horizontal_3,
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                          if (numActiveFilters > 0)
                            Positioned(
                                top: -16,
                                right: 0,
                                child: FadeIn(
                                    child: CircularBox(
                                        color: context.theme.primary,
                                        child: MyText(
                                          numActiveFilters.toString(),
                                          color: context.theme.background,
                                          lineHeight: 1.2,
                                          size: FONTSIZE.two,
                                        ))))
                        ],
                      ),
                    ]),
              ),
            ),
          ),
          const Expanded(child: WorkoutFiltersScreen())
        ],
      ),
      body: MyPageScaffold(
        navigationBar: MyNavBar(
          middle: const NavBarTitle('Find a Workout'),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => context.push(
                fullscreenDialog: true,
                child: WorkoutFinderTextSearch(
                    initialPageIndex: _activePageIndex,
                    userWorkouts: widget.userWorkouts,
                    updateActivePageIndex: _updatePageIndex,
                    selectWorkout:
                        widget.selectWorkout != null ? _selectWorkout : null)),
            child: const Icon(
              CupertinoIcons.search,
              size: 25,
            ),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: SizedBox(
                width: double.infinity,
                child: SlidingSelect<int>(
                    value: _activePageIndex,
                    updateValue: _updatePageIndex,
                    children: const {
                      0: MyText('Your Workouts'),
                      1: MyText('All Workouts'),
                    }),
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: _activePageIndex,
                children: [
                  YourFilteredWorkoutsList(
                    listPositionScrollController:
                        _userWorkoutsListScrollController,
                    selectWorkout:
                        widget.selectWorkout != null ? _selectWorkout : null,
                    workouts: _filteredUserWorkouts,
                  ),
                  PagedListView<int, Workout>(
                    // Bottom padding to push list up above floating filters panel.
                    padding: const EdgeInsets.only(top: 4, bottom: 138),
                    pagingController: _pagingController,
                    scrollController: _pagingScrollController,
                    builderDelegate: PagedChildBuilderDelegate<Workout>(
                      itemBuilder: (context, workout, index) => SizeFadeIn(
                        duration: 50,
                        delay: index,
                        delayBasis: 15,
                        child: WorkoutFinderWorkoutCard(
                          workout: workout,
                          selectWorkout: widget.selectWorkout != null
                              ? _selectWorkout
                              : null,
                        ),
                      ),
                      firstPageProgressIndicatorBuilder: (c) =>
                          const LoadingCircle(),
                      newPageProgressIndicatorBuilder: (c) =>
                          const LoadingCircle(),
                      noItemsFoundIndicatorBuilder: (c) =>
                          const Center(child: MyText('No results...')),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
