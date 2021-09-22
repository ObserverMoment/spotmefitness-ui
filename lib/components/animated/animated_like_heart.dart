import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sofie_ui/blocs/theme_bloc.dart';
import 'package:sofie_ui/components/animated/mounting.dart';
import 'package:sofie_ui/extensions/context_extensions.dart';
import 'package:supercharged/supercharged.dart';

class AnimatedLikeHeart extends StatefulWidget {
  final bool active;
  const AnimatedLikeHeart({
    Key? key,
    required this.active,
  }) : super(key: key);
  @override
  _AnimatedLikeHeartState createState() => _AnimatedLikeHeartState();
}

class _AnimatedLikeHeartState extends State<AnimatedLikeHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController _mainHeartController;
  late Animation<double> _mainHeartScaleAnimation;

  bool _isAnimating = false;
  final int _animDuration = 700;

  @override
  void initState() {
    super.initState();

    _mainHeartController = AnimationController(
      duration: Duration(milliseconds: _animDuration),
      vsync: this,
    );

    _mainHeartController.addListener(() {
      // Reset _isAnimating flag when completed.
      if (_mainHeartController.isDismissed ||
          _mainHeartController.isCompleted) {
        setState(() => _isAnimating = false);
      } else {
        setState(() => _isAnimating = true);
      }
    });

    if (widget.active) {
      _mainHeartController.forward();
    } else {
      _mainHeartController.reset();
    }

    _mainHeartScaleAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.1)
              .chain(CurveTween(curve: Curves.elasticInOut)),
          weight: 90.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.1, end: 1.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 10.0,
        ),
      ],
    ).animate(_mainHeartController);
  }

  @override
  void didUpdateWidget(AnimatedLikeHeart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active != oldWidget.active) {
      if (widget.active) {
        _mainHeartController.forward();
      } else {
        _mainHeartController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _mainHeartController.dispose();
    super.dispose();
  }

  Widget _buildMiniHeart(double yTranslate, Offset offset, double opacity) {
    return Transform.translate(
      offset: offset,
      child: FadeInUp(
        duration: _animDuration,
        yTranslate: yTranslate,
        child: Icon(CupertinoIcons.heart_solid,
            size: 12, color: Styles.heartRed.withOpacity(opacity)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
              animation: _mainHeartController,
              builder: (BuildContext context, _) => Stack(
                    alignment: Alignment.center,
                    children: [
                      if (!widget.active)
                        FadeIn(
                          child: Icon(CupertinoIcons.heart,
                              size: 32,
                              color: context.theme.primary.withOpacity(0.7)),
                        ),
                      if (_isAnimating && widget.active)
                        _buildMiniHeart(-28, const Offset(8, 2), 0.85),
                      if (_isAnimating && widget.active)
                        _buildMiniHeart(-24, const Offset(-8, 4), 0.95),
                      if (_isAnimating && widget.active)
                        _buildMiniHeart(-34, Offset.zero, 0.7),
                      ScaleTransition(
                        scale: _mainHeartScaleAnimation,
                        child: const Icon(CupertinoIcons.heart_solid,
                            size: 32, color: Styles.heartRed),
                      ),
                      if (_isAnimating && widget.active)
                        ...List.generate(
                            3,
                            (index) => _PulsingCircle(
                                animDuration: _animDuration,
                                delay: index * (_animDuration ~/ 2))),
                    ],
                  )),
        ],
      ),
    );
  }
}

enum _PulsingCircleAnimProps { scale, opacity }

class _PulsingCircle extends StatelessWidget {
  final int animDuration;
  final int delay;
  const _PulsingCircle({required this.delay, required this.animDuration});

  @override
  Widget build(BuildContext context) {
    final int _subAnimDuration = animDuration - delay;

    final tween = MultiTween<_PulsingCircleAnimProps>()
      ..add(_PulsingCircleAnimProps.opacity, 0.1.tweenTo(0.15),
          (_subAnimDuration * 0.95).round().milliseconds)
      ..add(_PulsingCircleAnimProps.opacity, 0.4.tweenTo(0.0),
          (_subAnimDuration * 0.05).round().milliseconds)
      ..add(
        _PulsingCircleAnimProps.scale,
        0.4.tweenTo(1.1),
        _subAnimDuration.milliseconds,
      );

    return PlayAnimation<MultiTweenValues<_PulsingCircleAnimProps>>(
      delay: delay.milliseconds,
      duration: _subAnimDuration.milliseconds,
      tween: tween,
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          border: Border.all(color: context.theme.primary, width: 3),
          shape: BoxShape.circle,
        ),
      ),
      builder: (context, child, value) => Opacity(
        opacity: value.get(_PulsingCircleAnimProps.opacity),
        child: Transform.scale(
          scale: value.get(_PulsingCircleAnimProps.scale),
          child: child,
        ),
      ),
    );
  }
}
