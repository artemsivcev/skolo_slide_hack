import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'win_animation_state.g.dart';

class WinAnimationState = _WinAnimationState with _$WinAnimationState;

/// State is used for showing animation when the user wins the game.
abstract class _WinAnimationState with Store {
  /// tween for flipping tiles
  final Tween<double> tweenForFlipping = Tween(begin: pi, end: 0.0);

  /// tween for spacing between elements in [PuzzleBoard]
  final Tween<double> tweenForSpacing = Tween(begin: 3.0, end: 0.0);

  /// tween for fading in/out empty tile
  final Tween<double> tweenForFade = Tween(begin: 0, end: 1);

  @observable
  AnimationController? animationController;

  /// animation for fading
  @observable
  Animation<double>? fadeAnimation;

  /// animation for space between puzzle tiles.
  @observable
  Animation<double>? spacingAnimation;

  @observable
  double spacingValue = 3.0;

  /// bool for checking if the animation is completed
  @observable
  bool isAnimCompleted = false;

  /// init the controller and animations
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

    fadeAnimation = tweenForFade.animate(
      CurvedAnimation(
        parent: animationController!,
        curve: const Interval(
          0.0,
          0.55,
          curve: Curves.easeIn,
        ),
      ),
    );

    spacingAnimation = tweenForSpacing.animate(animationController!)
      ..addListener(() {
        spacingValue = spacingAnimation!.value;
      });
  }

  /// function for animating
  @action
  void animate() {
    isAnimCompleted
        ? animationController!.reset()
        : animationController!.forward();
  }

  /// reset animation
  @action
  void resetAnimation() {
    animationController?.reset();
    isAnimCompleted = false;
    spacingValue = 3.0;
  }
}
