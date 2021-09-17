import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/components/animated/loading_shimmers.dart';
import 'package:spotmefitness_ui/components/future_builder_handler.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:spotmefitness_ui/router.gr.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:spotmefitness_ui/services/store/store_utils.dart';

/// Gets the workout from the DB based on its ID and then inits the DoWorkoutBloc.
/// Uses [AutoRouter.declarative] to move the user from the do workout page to the log workout page onec all workout sections are completed.
class DoWorkoutWrapperPage extends StatefulWidget {
  final String id;
  final ScheduledWorkout? scheduledWorkout;
  const DoWorkoutWrapperPage(
      {Key? key, @PathParam('id') required this.id, this.scheduledWorkout})
      : super(key: key);

  @override
  _DoWorkoutWrapperPageState createState() => _DoWorkoutWrapperPageState();
}

class _DoWorkoutWrapperPageState extends State<DoWorkoutWrapperPage> {
  /// https://stackoverflow.com/questions/57793479/flutter-futurebuilder-gets-constantly-called
  late Future<Workout> _initWorkoutFuture;

  Future<Workout> _getWorkoutById() async {
    final variables = WorkoutByIdArguments(id: widget.id);
    final query = WorkoutByIdQuery(variables: variables);

    final result =
        await context.graphQLStore.networkOnlyOperation(operation: query);

    await checkOperationResult(context, result);

    return result.data!.workoutById;
  }

  Widget get _loadingWidget => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/logos/sofie_logo.svg',
            width: 40,
            color: context.theme.primary,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyText('WARMING UP'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoadingDots(),
          ),
        ],
      );

  @override
  void initState() {
    super.initState();
    _initWorkoutFuture = _getWorkoutById();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilderHandler<Workout>(
        loadingWidget: _loadingWidget,
        future: _initWorkoutFuture,
        builder: (workout) => ChangeNotifierProvider<DoWorkoutBloc>(
              create: (context) => DoWorkoutBloc(
                originalWorkout: workout,
              ),
              builder: (context, _) {
                final mediaSetupComplete = context.select<DoWorkoutBloc, bool>(
                    (b) => b.audioInitSuccess && b.videoInitSuccess);

                if (!mediaSetupComplete) return _loadingWidget;

                final allSectionsComplete = context.select<DoWorkoutBloc, bool>(
                    (b) =>
                        b.activeWorkout.workoutSections.length ==
                        b.loggedWorkout.loggedWorkoutSections.length);

                return AutoRouter.declarative(
                    routes: (_) => [
                          if (!allSectionsComplete) DoWorkoutDoWorkoutRoute(),
                          if (allSectionsComplete)
                            DoWorkoutLogWorkoutRoute(
                                scheduledWorkout: widget.scheduledWorkout),
                        ]);
              },
            ));
  }
}
