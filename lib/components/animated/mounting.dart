import 'package:flutter/cupertino.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum _AniProps { opacity, translateY }

// https://github.com/felixblaschke/simple_animations/blob/master/example/lib/examples/fade_in_ui.dart
class FadeInUp extends StatelessWidget {
  final int delay; // Enables staggering of animations - for example down a list
  final Widget child;
  final int duration;
  final double delayBasis;
  final double yTranslate;
  FadeInUp(
      {this.delay = 0,
      required this.child,
      this.duration = 250,
      this.delayBasis = 150,
      this.yTranslate = 10});
  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_AniProps>()
      ..add(_AniProps.opacity, 0.0.tweenTo(1.0))
      ..add(_AniProps.translateY, yTranslate.tweenTo(0.0));

    return PlayAnimation<MultiTweenValues<_AniProps>>(
      delay: (delayBasis * delay).round().milliseconds,
      duration: duration.milliseconds,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(_AniProps.opacity),
        child: Transform.translate(
          offset: Offset(0, value.get(_AniProps.translateY)),
          child: child,
        ),
      ),
    );
  }
}

class FadeIn extends StatelessWidget {
  final int delay; // Enables staggering of animations - for example down a list
  final Widget child;
  final int duration;
  final double delayBasis;
  final Key? key;
  FadeIn(
      {this.key,
      this.delay = 0,
      required this.child,
      this.duration = 500,
      this.delayBasis = 300});
  @override
  Widget build(BuildContext context) {
    final tween = 0.0.tweenTo(1.0);

    return PlayAnimation<double>(
      delay: (delayBasis * delay).round().milliseconds,
      duration: duration.milliseconds,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value,
        child: child,
      ),
    );
  }
}

/// Wrap around a child so that it grows into full size (via Transform.scale).
/// Specify alignment to select from where (origin) the objects grows. Default is topCenter.
class GrowIn extends StatelessWidget {
  /// Enables staggering of animations - for example down a list
  final int delay;

  final Widget child;
  final int duration;
  final double delayBasis;
  final Key? key;
  final Alignment growInfrom;
  final Curve curve;
  GrowIn(
      {this.key,
      this.delay = 0,
      required this.child,
      this.duration = 500,
      this.growInfrom = Alignment.topCenter,
      this.curve = Curves.fastOutSlowIn,
      this.delayBasis = 300});
  @override
  Widget build(BuildContext context) {
    final tween = 0.0.tweenTo(1.0);

    return PlayAnimation<double>(
      delay: (delayBasis * delay).round().milliseconds,
      duration: duration.milliseconds,
      tween: tween,
      child: child,
      curve: curve,
      builder: (context, child, value) => SizeTransition(
        // TODO: Is this hacky?? Performance??
        sizeFactor: AlwaysStoppedAnimation<double>(value),
        child: Opacity(opacity: value, child: child),
      ),
    );
  }
}

/// Stateful ticker widget that grows in or shrinks out based on [show] boolean.
class GrowInOut extends StatefulWidget {
  /// Enables staggering of animations - for example down a list
  final bool show;
  final Widget child;
  final Duration duration;
  final Key? key;
  final Curve curve;
  final Axis axis;
  final double axisAlignment;
  final bool animateOpacity;

  GrowInOut({
    required this.show,
    this.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.axis = Axis.vertical,
    this.axisAlignment = 0.0,
    this.curve = Curves.fastOutSlowIn,
    this.animateOpacity = false,
  });

  @override
  _GrowInOutState createState() => _GrowInOutState();
}

class _GrowInOutState extends State<GrowInOut>
    with SingleTickerProviderStateMixin {
  late Animation<double> _sizeFactor;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _sizeFactor = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _controller.animateTo(widget.show ? 1 : 0,
        duration: Duration(milliseconds: 1));
  }

  @override
  void didUpdateWidget(GrowInOut oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.show != widget.show) {
      _runAnimation();
    }
  }

  void _runAnimation() {
    if (widget.show) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _sizeFactor,
      axis: widget.axis,
      axisAlignment: widget.axisAlignment,
      child: widget.animateOpacity
          ? AnimatedOpacity(
              opacity: widget.show ? 1 : 0,
              duration: widget.duration,
              curve: widget.curve,
              child: widget.child)
          : widget.child,
    );
  }
}
