import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'win_animation_state.g.dart';

class WinAnimationState = _WinAnimationState with _$WinAnimationState;

abstract class _WinAnimationState with Store {
  /// tween for flipping tiles
  final Tween<double> tweenForFlipping = Tween(begin: pi, end: 0.0);

  /// tween for spacing between elements in [PuzzleBoard]
  final Tween<double> tweenForSpacing = Tween(begin: 4.0, end: 0.0);

  @observable
  AnimationController? animationController;

  @observable
  Animation<double>? fadeAnimation;

  @observable
  Animation<double>? spacingAnimation;

  @observable
  double spacingValue = 4.0;

  @observable
  bool isAnimCompleted = false;

  @action
  void initAnimation(AnimationController controller) {
    animationController = controller
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          isAnimCompleted = true;
        }

        if (status == AnimationStatus.dismissed) {
          isAnimCompleted = false;
        }
      });

    fadeAnimation = CurvedAnimation(
      parent: animationController!,
      curve: Curves.ease,
    );

    spacingAnimation = tweenForSpacing.animate(animationController!)
      ..addListener(() {
        spacingValue = spacingAnimation!.value;
      });
  }

  @action
  void disposeControllers() {
    animationController!.dispose();
  }

  @action
  void animate() => isAnimCompleted
      ? animationController!.reset()
      : animationController!.forward();
}
