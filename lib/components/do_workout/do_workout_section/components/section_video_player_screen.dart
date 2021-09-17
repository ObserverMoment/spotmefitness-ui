import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/components/indicators.dart';
import 'package:spotmefitness_ui/generated/api/graphql_api.dart';
import 'package:provider/provider.dart';

class SectionVideoPlayerScreen extends StatefulWidget {
  final WorkoutSection workoutSection;
  const SectionVideoPlayerScreen({Key? key, required this.workoutSection})
      : super(key: key);

  @override
  _SectionVideoPlayerScreenState createState() =>
      _SectionVideoPlayerScreenState();
}

class _SectionVideoPlayerScreenState extends State<SectionVideoPlayerScreen> {
  late BetterPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = context
        .read<DoWorkoutBloc>()
        .getVideoControllerForSection(widget.workoutSection.sortPosition);
  }

  @override
  Widget build(BuildContext context) {
    return _videoController == null
        ? LoadingDots()
        : BetterPlayer(
            controller: _videoController!,
          );
  }
}
