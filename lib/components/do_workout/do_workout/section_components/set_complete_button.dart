import 'package:flutter/cupertino.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

class SetCompleteButton extends StatelessWidget {
  final void Function() onPressed;
  const SetCompleteButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: CupertinoButton(
                onPressed: onPressed,
                padding: EdgeInsets.zero,
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  decoration: BoxDecoration(
                      color: context.theme.primary,
                      borderRadius: BorderRadius.circular(50)),
                  child: MyText(
                    'SET COMPLETE',
                    color: context.theme.background,
                    weight: FontWeight.bold,
                    size: FONTSIZE.BIG,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
