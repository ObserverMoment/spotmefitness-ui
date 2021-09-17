import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';

/// Animates into a tick and then animates resets, ready for another submission.
/// Only the text animates into a tick - the rest of the container does not animate. Variation on [AnimatedSubmitButton].
class AnimatedSubmitButtonV2 extends StatefulWidget {
  /// The size of the sliding icon
  final double checkIconSize;

  /// The height of the component
  final double height;

  /// The text showed in the default Text widget
  final String? text;

  final FONTSIZE fontSize;

  /// The borderRadius of the sliding icon and of the background
  final double borderRadius;

  /// Callback called on submit
  /// If this is null the component will not animate to complete
  final VoidCallback? onSubmit;

  /// The duration of the animations
  final Duration animationDuration;

  /// Create a new instance of the widget
  const AnimatedSubmitButtonV2({
    Key? key,
    this.checkIconSize = 34,
    this.height = 70,
    this.borderRadius = 52,
    this.animationDuration = const Duration(milliseconds: 300),
    this.onSubmit,
    this.text,
    this.fontSize = FONTSIZE.LARGE,
  }) : super(key: key);
  @override
  AnimatedSubmitButtonV2State createState() => AnimatedSubmitButtonV2State();
}

/// Use a GlobalKey to access the state. This is the only way to call [setCompleteButtonState.reset]
class AnimatedSubmitButtonV2State extends State<AnimatedSubmitButtonV2>
    with TickerProviderStateMixin {
  final GlobalKey _containerKey = GlobalKey();
  double _checkAnimationDx = 0;
  bool submitted = false;
  late AnimationController _checkAnimationController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!submitted) {
          widget.onSubmit!();
          await _checkAnimation();
          Future.delayed(Duration(milliseconds: 300), () async {
            await reset();
          });
        }
      },
      child: Align(
        alignment: Alignment.center,
        child: Container(
          key: _containerKey,
          height: widget.height,
          constraints: BoxConstraints.expand(height: widget.height),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              color: Styles.neonBlueOne),
          child: Center(
              child: submitted
                  ? Stack(
                      clipBehavior: Clip.antiAlias,
                      children: <Widget>[
                        Icon(
                          CupertinoIcons.checkmark_alt,
                          color: Styles.white,
                          size: widget.checkIconSize,
                        ),
                        Positioned.fill(
                          right: 0,
                          child: Transform(
                            transform:
                                Matrix4.rotationY(_checkAnimationDx * (pi / 2)),
                            alignment: Alignment.centerRight,
                            child: Container(
                              color: Styles.neonBlueOne,
                            ),
                          ),
                        ),
                      ],
                    )
                  : MyText(
                      submitted == true
                          ? ''
                          : (widget.text ?? 'Submit').toUpperCase(),
                      textAlign: TextAlign.center,
                      size: widget.fontSize,
                      color: Styles.white,
                    )),
        ),
      ),
    );
  }

  /// Call this method to revert the animations
  Future reset() async {
    if (mounted) {
      await _checkAnimationController.reverse();
      submitted = false;
    }
  }

  Future _checkAnimation() async {
    if (mounted) {
      _checkAnimationController.reset();

      final animation = Tween<double>(
        begin: 0,
        end: 1,
      ).animate(CurvedAnimation(
        parent: _checkAnimationController,
        curve: Curves.slowMiddle,
      ));

      animation.addListener(() {
        if (mounted) {
          setState(() {
            _checkAnimationDx = animation.value;
          });
        }
      });

      setState(() {
        submitted = true;
      });

      await _checkAnimationController.forward();
    }
  }

  @override
  void initState() {
    super.initState();

    _checkAnimationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
  }

  @override
  void dispose() {
    _checkAnimationController.dispose();
    super.dispose();
  }
}
