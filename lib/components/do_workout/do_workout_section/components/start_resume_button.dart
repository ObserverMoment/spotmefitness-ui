import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/blocs/do_workout_bloc/do_workout_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

class StartResumeButton extends StatelessWidget {
  final int sectionIndex;
  const StartResumeButton({Key? key, required this.sectionIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sectionHasStarted = context.select<DoWorkoutBloc, bool>(
        (b) => b.getControllerForSection(sectionIndex).sectionHasStarted);
    return CupertinoButton(
        pressedOpacity: null,
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Container(
          height: 70,
          // Must match [AnimatedSubmitButton] height.
          decoration: BoxDecoration(color: context.theme.primary),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.play,
                color: context.theme.background,
              ),
              SizedBox(width: 6),
              MyText(sectionHasStarted ? 'RESUME' : 'START',
                  color: context.theme.background, size: FONTSIZE.LARGE)
            ],
          ),
        ),
        onPressed: () =>
            context.read<DoWorkoutBloc>().playSection(sectionIndex));
  }
}
