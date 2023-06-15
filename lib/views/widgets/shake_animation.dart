import 'dart:math';
import 'package:flutter/material.dart';

abstract class AnimationControllerState<T extends StatefulWidget>
    extends State<T> with SingleTickerProviderStateMixin {
  AnimationControllerState();

  static const _animationDuration = Duration(seconds: 2);

  late final animationController = AnimationController(
    vsync: this,
    duration: _animationDuration,
  );

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class SineCurve extends Curve {
  const SineCurve({required this.count});

  final double count;

  @override
  double transformInternal(double t) {
    return sin((2 * pi) * count * t);
  }
}

class ShakeAnimation extends StatefulWidget {
  const ShakeAnimation({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ShakeAnimation> createState() => ShakeAnimationState();
}

class ShakeAnimationState extends AnimationControllerState<ShakeAnimation> {
  static const _shakeCount = 10.0;
  static const _shakeOffset = 8.0;

  late final Animation<double> _sineAnimation =
      Tween(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: animationController,
      curve: const SineCurve(count: _shakeCount),
    ),
  );

  void shake() {
    animationController.forward();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }

  @override
  void initState() {
    animationController.addStatusListener((status) {
      _updateStatus(status);
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.removeStatusListener((status) {
      _updateStatus(status);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sineAnimation,
      child: widget.child,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset((_sineAnimation.value * _shakeOffset), 0),
          child: child,
        );
      },
    );
  }
}
