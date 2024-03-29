import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:sofie_ui/components/animated/mounting.dart';
import 'package:sofie_ui/components/buttons.dart';
import 'package:sofie_ui/components/cards/workout_card.dart';
import 'package:sofie_ui/components/layout.dart';
import 'package:sofie_ui/components/text.dart';
import 'package:sofie_ui/components/user_input/pickers/sliding_select.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:sofie_ui/extensions/type_extensions.dart';
import 'package:sofie_ui/generated/api/graphql_api.dart';
import 'package:sofie_ui/pages/authed/home/your_workouts/your_created_workouts.dart';
import 'package:sofie_ui/pages/authed/home/your_workouts/your_saved_workouts.dart';
import 'package:sofie_ui/pages/authed/home/your_workouts/your_workouts_text_search.dart';
import 'package:sofie_ui/router.gr.dart';

class YourWorkoutsPage extends StatefulWidget {
  const YourWorkoutsPage({Key? key}) : super(key: key);

  @override
  _YourWorkoutsPageState createState() => _YourWorkoutsPageState();
}

class _YourWorkoutsPageState extends State<YourWorkoutsPage> {
  /// 0 = Created Workouts, 1 = Saved Workouts - via collections
  int _activeTabIndex = 0;
  final PageController _pageController = PageController();

  void _updatePageIndex(int index) {
    setState(() => _activeTabIndex = index);
    _pageController.toPage(_activeTabIndex);
  }

  void _openWorkoutDetails(String id) {
    context.navigateTo(WorkoutDetailsRoute(id: id));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyPageScaffold(
        navigationBar: MyNavBar(
          middle: const NavBarTitle('Your Workouts'),
          trailing: NavBarTrailingRow(
            children: [
              CreateIconButton(
                onPressed: () => context.navigateTo(WorkoutCreatorRoute()),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => context.push(
                    rootNavigator: true,
                    child: YourWorkoutsTextSearch(
                      selectWorkout: (id) => _openWorkoutDetails(id),
                    )),
                child: const Icon(CupertinoIcons.search),
              ),
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: SizedBox(
                width: double.infinity,
                child: SlidingSelect<int>(
                    value: _activeTabIndex,
                    updateValue: _updatePageIndex,
                    children: const {
                      0: MyText('Created'),
                      1: MyText('Saved'),
                    }),
              ),
            ),
            Expanded(
                child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                YourCreatedWorkouts(
                  selectWorkout: (id) => _openWorkoutDetails(id),
                ),
                YourSavedWorkouts(
                  selectWorkout: (id) => _openWorkoutDetails(id),
                )
              ],
            ))
          ],
        ));
  }
}

class YourWorkoutsList extends StatelessWidget {
  final List<Workout> workouts;
  final void Function(String workoutId) selectWorkout;
  const YourWorkoutsList(
      {Key? key, required this.workouts, required this.selectWorkout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return workouts.isEmpty
        ? const Padding(
            padding: EdgeInsets.all(24),
            child: MyText('No workouts to display...'))
        : ListView.builder(
            shrinkWrap: true,
            itemCount: workouts.length,
            itemBuilder: (c, i) => GestureDetector(
                  key: Key(workouts[i].id),
                  onTap: () => selectWorkout(workouts[i].id),
                  child: SizeFadeIn(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: WorkoutCard(workouts[i]),
                    ),
                  ),
                ));
  }
}
