import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:provider/provider.dart';

class StartResumeButton extends StatelessWidget {
  final int sectionIndex;
  final double height;
  const StartResumeButton(
      {Key? key, required this.sectionIndex, required this.height})
      : super(key: key);

  /// Runs a countdown animation and THEN starts the workout.
  void _startSection(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (context) {
          return Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: CupertinoActionSheet(
                  title:
                      MyHeaderText('GET READY!', textAlign: TextAlign.center),
                  message: SizedBox(
                    height: 120,
                    child: MyText('Animated text here'),
                  ),
                ),
              ));
        });
  }

  void _playSection(BuildContext context) {
    context.read<DoWorkoutBloc>().playSection(sectionIndex);
  }

  @override
  Widget build(BuildContext context) {
    final sectionHasStarted = context.select<DoWorkoutBloc, bool>(
        (b) => b.getControllerForSection(sectionIndex).sectionHasStarted);
    return GestureDetector(
      onTap: () =>
          sectionHasStarted ? _playSection(context) : _startSection(context),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: Styles.secondaryButtonGradient,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.play,
              color: Styles.white,
            ),
            SizedBox(width: 6),
            MyText(sectionHasStarted ? 'RESUME' : 'START',
                color: Styles.white, size: FONTSIZE.LARGE)
          ],
        ),
      ),
    );
  }
}
