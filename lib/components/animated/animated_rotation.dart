import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotmefitness_ui/constants.dart';

class AnimatedRotation extends StatefulWidget {
  final bool rotate;
  final Widget child;
  AnimatedRotation({
    required this.rotate,
    required this.child,
  });
  @override
  _AnimatedRotationState createState() => _AnimatedRotationState();
}

class _AnimatedRotationState extends State<AnimatedRotation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: kStandardAnimationDuration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 0.5).animate(
        CurvedAnimation(parent: _controller, curve: Curves.linearToEaseOut));
  }

  @override
  void didUpdateWidget(AnimatedRotation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.rotate != oldWidget.rotate) {
      if (widget.rotate) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(turns: _animation, child: widget.child);
  }
}
