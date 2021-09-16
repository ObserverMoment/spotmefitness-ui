import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/blocs/theme_bloc.dart';
import 'package:spotmefitness_ui/components/text.dart';
import 'package:spotmefitness_ui/extensions/context_extensions.dart';

/// Animates into a tick and then animates resets, ready for another submission.
class AnimatedSubmitButton extends StatefulWidget {
  /// The size of the sliding icon
  final double setCompleteButtonIconSize;

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

  /// Elevation of the component
  final double elevation;

  /// The duration of the animations
  final Duration animationDuration;

  /// Create a new instance of the widget
  const AnimatedSubmitButton({
    Key? key,
    this.setCompleteButtonIconSize = 34,
    this.height = 70,
    this.borderRadius = 52,
    this.elevation = 6,
    this.animationDuration = const Duration(milliseconds: 200),
    this.onSubmit,
    this.text,
    this.fontSize = FONTSIZE.LARGE,
  }) : super(key: key);
  @override
  AnimatedSubmitButtonState createState() => AnimatedSubmitButtonState();
}

/// Use a GlobalKey to access the state. This is the only way to call [setCompleteButtonState.reset]
class AnimatedSubmitButtonState extends State<AnimatedSubmitButton>
    with TickerProviderStateMixin {
  final GlobalKey _containerKey = GlobalKey();
  double? _initialContainerWidth, _containerWidth;
  double _checkAnimationDx = 0;
  bool submitted = false;
  late AnimationController _checkAnimationController,
      _shrinkAnimationController;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      pressedOpacity: 0.9,
      padding: const EdgeInsets.symmetric(vertical: 4),
      onPressed: () async {
        if (!submitted) {
          widget.onSubmit!();
          await _shrinkAnimation();
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
          width: _containerWidth,
          constraints: _containerWidth != null
              ? null
              : BoxConstraints.expand(height: widget.height),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(submitted ? 100 : widget.borderRadius),
              color: Styles.neonBlueOne),
          child: Center(
              child: submitted
                  ? Stack(
                      clipBehavior: Clip.antiAlias,
                      children: <Widget>[
                        Icon(
                          CupertinoIcons.checkmark_alt,
                          color: Styles.white,
                          size: widget.setCompleteButtonIconSize,
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
                      weight: FontWeight.bold,
                    )),
        ),
      ),
    );
  }

  /// Call this method to revert the animations
  Future reset() async {
    if (mounted) {
      await _checkAnimationController.reverse();
      await _shrinkAnimationController.reverse();
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
      await _checkAnimationController.forward();
    }
  }

  Future _shrinkAnimation() async {
    if (mounted) {
      _shrinkAnimationController.reset();

      final diff = _initialContainerWidth! - widget.height;
      final animation = Tween<double>(
        begin: 0,
        end: 1,
      ).animate(CurvedAnimation(
        parent: _shrinkAnimationController,
        curve: Curves.easeOutCirc,
      ));

      animation.addListener(() {
        if (mounted) {
          setState(() {
            _containerWidth =
                _initialContainerWidth! - (diff * animation.value);
          });
        }
      });

      setState(() {
        submitted = true;
      });
      await _shrinkAnimationController.forward();
    }
  }

  @override
  void initState() {
    super.initState();

    _checkAnimationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _shrinkAnimationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final RenderBox containerBox =
          _containerKey.currentContext!.findRenderObject() as RenderBox;
      _containerWidth = containerBox.size.width;
      _initialContainerWidth = _containerWidth;
    });
  }

  @override
  void dispose() {
    _checkAnimationController.dispose();
    _shrinkAnimationController.dispose();
    super.dispose();
  }
}
