import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class AnimacionOpacity extends StatelessWidget {
  final int delay;
  final Widget child;
  AnimacionOpacity({this.delay, this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(Duration(milliseconds: delay), Tween(begin: 0.0, end: 1.0)),
    ]);

    return ControlledAnimation(
      delay: tween.duration,
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: child
      ),
    );
  }
}