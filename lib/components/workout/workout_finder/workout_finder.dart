import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/animated/mounting.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/cards/workout_card.dart';
import 'package:spotmefitness_ui/components/layout.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/click_to_edit/pickers/sliding_select.dart';
import 'package:spotmefitness_ui/components/user_input/filters/blocs/workout_filters_bloc.dart';
import 'package:spotmefitness_ui/components/user_input/filters/screens/workout_filters_screen.dart';
import 'package:spotmefitness_ui/components/user_input/menus/context_menu.dart';
import 'package:spotmefitness_ui/components/workout/workout_finder/workout_finder_text_search.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/services/store/query_observer.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart' as json;

/// Widget that uses filters to find and select a workout.
/// Wrapper around the UI which handles the [ObservableQuery] [UserWorkouts]
class WorkoutFinderPage extends StatelessWidget {
  final void Function(Workout workout) selectWorkout;
  WorkoutFinderPage(this.selectWorkout);

  @override
  Widget build(BuildContext context) {
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

          return WorkoutFinderPageUI(
            selectWorkout: selectWorkout,
            userWorkouts: userWorkouts,
          );
        });
  }
}

class WorkoutFinderPageUI extends StatefulWidget {
  final List<Workout> userWorkouts;
  final void Function(Workout workout) selectWorkout;
  WorkoutFinderPageUI(
      {required this.userWorkouts, required this.selectWorkout});

  @override
  _WorkoutFinderPageUIState createState() => _WorkoutFinderPageUIState();
}

class _WorkoutFinderPageUIState extends State<WorkoutFinderPageUI> {
  final kPanelBorderRadius = 30.0;
  final kCollapsedpanelheight = 66.0;

  final PanelController _panelController = PanelController();
  bool _panelIsOpen = false;

  /// 0 is your workouts, 1 is public workouts.
  int _activePageIndex = 0;
  PageController _pageController = PageController();

  late WorkoutFiltersBloc _bloc;
  late WorkoutFilters _lastUsedFilters;
  List<Workout> _filteredUserWorkouts = [];
  List<Workout> _retrievedPublicWorkouts = [];

  @override
  void initState() {
    super.initState();
    _bloc = context.read<WorkoutFiltersBloc>();
    _updateLastUsedFilters();
    _filteredUserWorkouts = _bloc.filterYourWorkouts(widget.userWorkouts);
  }

  void _updateLastUsedFilters() {
    _lastUsedFilters = WorkoutFilters.fromJson(_bloc.filters.toJson());
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
      print('filtersHaveChanged');
      _updateLastUsedFilters();
      if (_activePageIndex == 0) {
        _filteredUserWorkouts = _bloc.filterYourWorkouts(widget.userWorkouts);
        setState(() {});
      } else {
        /// Refetch results - replacing current list.
        setState(() {});
      }
    }
  }

  void _clearAllFilters() {
    _bloc.clearAllFilters();
    setState(() {
      _updateLastUsedFilters();
      _filteredUserWorkouts = [...widget.userWorkouts];
    });
  }

  /// Pops itself (and any stack items such as the text seach widget)
  /// Then passes the selected workout to the parent.
  void _selectWorkout(Workout workout) {
    context.router.popUntilRoot();
    widget.selectWorkout(workout);
  }

  void _updatePageIndex(int index) {
    setState(() => _activePageIndex = index);
    _pageController.jumpToPage(_activePageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    final numActiveFilters =
        context.select<WorkoutFiltersBloc, int>((b) => b.numActiveFilters);

    return CupertinoPageScaffold(
        child: SafeArea(
      child: SlidingUpPanel(
        color: context.theme.cardBackground,
        controller: _panelController,
        onPanelClosed: _handlePanelClose,
        border: Border.all(color: context.theme.primary.withOpacity(0.05)),
        minHeight: kCollapsedpanelheight,
        maxHeight: size.height,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kPanelBorderRadius),
            topRight: Radius.circular(kPanelBorderRadius)),
        margin: const EdgeInsets.symmetric(horizontal: 8),
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
                          numActiveFilters == 0
                              ? MyText('No active filters', subtext: true)
                              : MyText('$numActiveFilters active filters'),
                          if (numActiveFilters > 0)
                            FadeIn(
                              child: TextButton(
                                  text: 'Clear all',
                                  onPressed: _clearAllFilters),
                            )
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
            Expanded(child: WorkoutFiltersScreen())
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
                      initialPageIndex: _activePageIndex,
                      userWorkouts: widget.userWorkouts,
                      updateActivePageIndex: _updatePageIndex,
                      selectWorkout: _selectWorkout)),
              child: Icon(
                CupertinoIcons.search,
                size: 25,
              ),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
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
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    WorkoutFinderFilteredWorkouts(
                      selectWorkout: _selectWorkout,
                      workouts: _filteredUserWorkouts,
                    ),
                    WorkoutFinderFilteredWorkouts(
                      selectWorkout: _selectWorkout,
                      workouts: _retrievedPublicWorkouts,
                    )
                  ],
                ),
              ),
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

  Widget _buildCard(BuildContext context, Workout workout) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: ContextMenu(
        key: Key('workoutcard ${workout.id}'),
        child: WorkoutCard(workout),
        menuChild: WorkoutCard(
          workout,
          showEquipment: false,
          showMoves: false,
        ),
        actions: [
          ContextMenuAction(
              text: 'Select',
              iconData: CupertinoIcons.add,
              onTap: () => selectWorkout(workout)),
          ContextMenuAction(
              text: 'View',
              iconData: CupertinoIcons.eye,
              onTap: () =>
                  context.navigateTo(WorkoutDetailsRoute(id: workout.id))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ImplicitlyAnimatedList<Workout>(
        // Bottom padding to push list up above floating filters panel.
        padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 138),
        items: workouts,
        itemBuilder: (context, animation, Workout workout, i) =>
            SizeFadeTransition(
              sizeFraction: 0.7,
              curve: Curves.easeInOut,
              animation: animation,
              child: _buildCard(context, workout),
            ),
        removeItemBuilder: (context, animation, Workout oldWorkout) {
          return FadeTransition(
            opacity: animation,
            child: _buildCard(context, oldWorkout),
          );
        },
        areItemsTheSame: (a, b) => a == b);
  }
}
