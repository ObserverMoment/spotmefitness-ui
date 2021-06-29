import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/constants.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class StartWorkoutCountdownButton extends StatefulWidget {
  final double size;
  final void Function() startSectionAfterCountdown;
  const StartWorkoutCountdownButton(
      {Key? key, required this.size, required this.startSectionAfterCountdown})
      : super(key: key);

  @override
  _StartWorkoutCountdownButtonState createState() =>
      _StartWorkoutCountdownButtonState();
}

class _StartWorkoutCountdownButtonState
    extends State<StartWorkoutCountdownButton> {
  bool _startCountdown = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: widget.size,
      height: widget.size,
      child: CupertinoButton(
        onPressed: () => setState(() => _startCountdown = !_startCountdown),
        child: AnimatedSwitcher(
          duration: kStandardAnimationDuration,
          child: _startCountdown
              ? TimeCircularCountdown(
                  unit: CountdownUnit.second,
                  countdownTotal: 3,
                  onFinished: widget.startSectionAfterCountdown,
                  countdownCurrentColor: Styles.peachRed,
                  countdownTotalColor: context.theme.background,
                  countdownRemainingColor: context.theme.primary,
                  textStyle: GoogleFonts.courierPrime(
                      textStyle: TextStyle(
                    color: context.theme.primary,
                    fontSize: 40,
                  )),
                )
              : SizedBox.expand(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: context.theme.primary.withOpacity(0.6),
                            width: 1),
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                            colors: [Styles.colorTwo, Styles.peachRed])),
                    child: MyText(
                      'START',
                      weight: FontWeight.bold,
                      size: FONTSIZE.HUGE,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
