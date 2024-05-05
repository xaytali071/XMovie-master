import 'package:flutter/material.dart';

class ScaleUpAnimation extends StatelessWidget {
  final Duration duration;
  const ScaleUpAnimation({super.key, required this.child, required this.duration});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration:duration,
      curve: Curves.easeOut,
      builder: (context, double value, _) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
    );
  }
}