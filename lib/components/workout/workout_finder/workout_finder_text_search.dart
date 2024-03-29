import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/blocs/text_search_bloc.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/animated/mounting.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/indicators.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/user_input/pickers/sliding_select.dart';
import 'package:sofie_ui/components/workout/workout_finder/filtered_workouts_list.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/services/text_search_filters.dart';
import 'package:substring_highlight/substring_highlight.dart';

class WorkoutFinderTextSearch extends StatefulWidget {
  final List<Workout> userWorkouts;
  final void Function(Workout workout)? selectWorkout;
  final int initialPageIndex;
  final void Function(int index) updateActivePageIndex;

  const WorkoutFinderTextSearch(
      {Key? key,
      required this.userWorkouts,
      this.selectWorkout,
      this.initialPageIndex = 0,
      required this.updateActivePageIndex})
      : assert(initialPageIndex == 0 || initialPageIndex == 1),
        super(key: key);

  @override
  _WorkoutFinderTextSearchState createState() =>
      _WorkoutFinderTextSearchState();
}

class _WorkoutFinderTextSearchState extends State<WorkoutFinderTextSearch> {
  String _searchString = '';
  late FocusNode _focusNode;

  /// 0 is 'Your Workouts', 1 is 'Public Workouts'
  late int _activePageIndex;
  late PageController _pageController;
  List<Workout> _filteredUserWorkouts = [];

  /// Handles retrieving full workout objects from the API when the user presses submit (search) on the keyboard.
  late TextSearchBloc<Workout> _workoutsTextSearchBloc;

  /// Handles retrieving just workout names (similar to a suggestions list) as the user is typing their search query.
  late TextSearchBloc<TextSearchResult> _workoutNamesTextSearchBloc;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPageIndex);
    _activePageIndex = widget.initialPageIndex;
    _workoutsTextSearchBloc =
        TextSearchBloc<Workout>(context, TextSearchType.workout);
    _workoutNamesTextSearchBloc =
        TextSearchBloc<TextSearchResult>(context, TextSearchType.workoutName);

    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  void _updatePageIndex(int index) {
    widget.updateActivePageIndex(index);
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
      navigationBar: MyNavBar(
        withoutLeading: true,
        middle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: CupertinoSearchTextField(
            placeholder: _activePageIndex == 0
                ? 'Search your workouts'
                : 'Search all workouts',
            focusNode: _focusNode,
            onChanged: _handleSearchStringUpdate,
            onSubmitted: _handleSearchSubmit,
          ),
        ),
        trailing: NavBarTextButton(context.pop, 'Close'),
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 14),
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
            child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            if (_searchString.length > 2)
              _filteredUserWorkouts.isEmpty
                  ? const Center(
                      child: MyText(
                      'No results.',
                      subtext: true,
                    ))
                  : YourFilteredWorkoutsList(
                      selectWorkout: widget.selectWorkout,
                      workouts: _filteredUserWorkouts)
            else
              const Center(
                  child: MyText(
                'Enter at least 3 characters.',
                subtext: true,
              )),
            if (_searchString.length > 2)
              StreamBuilder<TextSearchState>(
                  initialData: TextSearchState.empty,
                  stream: StreamGroup.merge([
                    _workoutsTextSearchBloc.state,
                    _workoutNamesTextSearchBloc.state
                  ]),
                  builder: (context, stateSnapshot) {
                    return StreamBuilder<List<Workout>>(
                        initialData: const <Workout>[],
                        stream: _workoutsTextSearchBloc.results,
                        builder: (context, workoutsSnapshot) {
                          return StreamBuilder<List<TextSearchResult>>(
                              initialData: const <TextSearchResult>[],
                              stream: _workoutNamesTextSearchBloc.results,
                              builder: (context, workoutNamesSnapshot) {
                                // Handle state.
                                if (stateSnapshot.data ==
                                    TextSearchState.error) {
                                  return const Center(
                                    child: MyText(
                                      'Sorry, there was a problem getting results',
                                      color: Styles.errorRed,
                                    ),
                                  );
                                } else if (stateSnapshot.data ==
                                    TextSearchState.loading) {
                                  return const Center(child: LoadingCircle());
                                } else if (stateSnapshot.data ==
                                    TextSearchState.empty) {
                                  // Or show placeholder message.
                                  return const Center(
                                      child: MyText(
                                    'Enter at least 3 characters.',
                                    subtext: true,
                                  ));
                                } else {
                                  // Handle data
                                  // Always show names list if it is not empty
                                  if (workoutNamesSnapshot.data!.isNotEmpty) {
                                    return FadeIn(
                                      child: WorkoutFinderTextResultsNames(
                                        results: workoutNamesSnapshot.data!,
                                        searchString: _searchString,
                                        searchWorkoutName: _handleSearchSubmit,
                                      ),
                                    );
                                  } else if (workoutsSnapshot
                                      .data!.isNotEmpty) {
                                    // Or show workouts list if not empty.
                                    return FadeIn(
                                      child: YourFilteredWorkoutsList(
                                        workouts: workoutsSnapshot.data!,
                                        selectWorkout: widget.selectWorkout,
                                      ),
                                    );
                                  } else {
                                    // Or show empty results message.
                                    return const Center(
                                        child: MyText(
                                      'No results....',
                                      subtext: true,
                                    ));
                                  }
                                }
                              });
                        });
                  })
            else
              const Center(
                  child: MyText(
                'Enter at least 3 characters.',
                subtext: true,
              )),
          ],
        )),
      ]),
    );
  }
}

/// Text only list of names being returned from the api based on the user input.
/// On press of the text result we set the search string to the exact name of the search string and then run a text search returning full workout objects.
class WorkoutFinderTextResultsNames extends StatelessWidget {
  final List<TextSearchResult> results;
  final String searchString;
  final void Function(String name) searchWorkoutName;
  const WorkoutFinderTextResultsNames(
      {Key? key,
      required this.results,
      required this.searchString,
      required this.searchWorkoutName})
      : super(key: key);

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
                      const Icon(
                        CupertinoIcons.search,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      SubstringHighlight(
                          textStyle: TextStyle(
                              fontSize: 16,
                              color: context.theme.primary.withOpacity(0.7)),
                          textStyleHighlight: const TextStyle(
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
