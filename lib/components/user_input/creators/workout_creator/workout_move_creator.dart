import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/workout_creator_bloc.dart';
import 'package:spotmefitness_ui/components/buttons.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/components/user_input/selectors/move_selector.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/extensions/type_extensions.dart';

class WorkoutMoveCreator extends StatefulWidget {
  final int sectionIndex;
  final int setIndex;
  final WorkoutMove? workoutMove;
  WorkoutMoveCreator(
      {required this.sectionIndex, required this.setIndex, this.workoutMove});

  @override
  _WorkoutMoveCreatorState createState() => _WorkoutMoveCreatorState();
}

class _WorkoutMoveCreatorState extends State<WorkoutMoveCreator> {
  late WorkoutCreatorBloc _bloc;
  late PageController _pageController;
  late WorkoutMove? _activeWorkoutMove;

  @override
  void initState() {
    super.initState();
    _activeWorkoutMove = widget.workoutMove != null
        ? WorkoutMove.fromJson(widget.workoutMove!.toJson())
        : null;
    _bloc = context.read<WorkoutCreatorBloc>();
    _pageController =
        PageController(initialPage: widget.workoutMove == null ? 0 : 1);
    _pageController.addListener(() {
      setState(() {});
    });
    // Hack so that the pageView controller check in build method below (hasClients) works.
    // Detemines if the menu ellipsis displays.
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          leading: NavBarCancelButton(context.pop),
          middle: NavBarTitle('Set'),
          trailing: !_pageController.hasClients
              ? null
              : _pageController.page == 0
                  ? NavBarTextButton(
                      text: 'Edit >',
                      onPressed: () => _pageController.toPage(1),
                    )
                  : NavBarTextButton(
                      text: 'Change Move',
                      onPressed: () => _pageController.toPage(0),
                    )),
      child: Column(
        children: [
          Expanded(
            child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Column(
                    children: [
                      MoveSelector(
                        move: _activeWorkoutMove?.move,
                        selectMove: (move) => print(move),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      MyText('Move'),
                      MyText('Reps'),
                      MyText('RepType'),
                      MyText('Distance Unit?'),
                      MyText('LoadAmount / LoadUnit'),
                      MyText('Equipment'),
                    ],
                  )
                ]),
          ),
        ],
      ),
    );
  }
}

// id: ID!
//     sortPosition: Int!
//     reps: Float!
//     repType: WorkoutMoveRepType!
//     distanceUnit: DistanceUnit!
//     loadAmount: Float
//     loadUnit: LoadUnit!
//     Move: Move!
//     Equipment: Equipment
