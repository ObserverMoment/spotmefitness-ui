import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/wrappers.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class DoWorkoutWrapperPage extends StatefulWidget {
  final String id;
  const DoWorkoutWrapperPage({Key? key, @PathParam('id') required this.id})
      : super(key: key);

  @override
  _DoWorkoutWrapperPageState createState() => _DoWorkoutWrapperPageState();
}

class _DoWorkoutWrapperPageState extends State<DoWorkoutWrapperPage> {
  // 0 = Adjustments (optional).
  // 1 = Do it.
  // 2 = Log it.
  // 3 = Share it.
  int _pageIndex = 0;

  /// https://stackoverflow.com/questions/57793479/flutter-futurebuilder-gets-constantly-called
  late Future<Workout> _initWorkoutFn;
  Workout? _originalWorkout;

  /// This can be identical to the original if the user does not make adjustments.
  Workout? _adjustedWorkout;

  Future<Workout> _getWorkoutById() async {
    final variables = WorkoutByIdArguments(id: widget.id);
    final query = WorkoutByIdQuery(variables: variables);

    final response = await context.graphQLStore.execute(query);

    if ((response.errors != null && response.errors!.isNotEmpty) ||
        response.data == null) {
      throw Exception(
          'DoWorkoutWrapperPage._getWorkoutById was not able to retrieve data for workout ${widget.id}');
    } else {
      final workout =
          WorkoutById$Query.fromJson(response.data ?? {}).workoutById;
      _originalWorkout = workout;
      return workout;
    }
  }

  @override
  void initState() {
    super.initState();
    _initWorkoutFn = _getWorkoutById();
  }

  @override
  Widget build(BuildContext context) => FutureBuilderHandler<Workout>(
      loadingWidget: ShimmerDetailsPage(title: 'Warming Up'),
      future: _initWorkoutFn,
      builder: (workout) => AutoRouter.declarative(
          routes: (_) => [
                if (_pageIndex == 0) DoWorkoutDoWorkoutRoute(workout: workout),
                if (_pageIndex == 1) DoWorkoutLogWorkoutRoute(),
                if (_pageIndex == 2) DoWorkoutShareWorkoutRoute(),
              ]));
}
