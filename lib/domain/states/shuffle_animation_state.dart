import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'shuffle_animation_state.g.dart';

class ShuffleAnimationState = _ShuffleAnimationState
    with _$ShuffleAnimationState;

abstract class _ShuffleAnimationState with Store {
  @observable
  AnimationController? animationShuffleController;

  @observable
  Animation<double>? offsetAnimation;

  final Tween<double> tweenForOffset = Tween(begin: 0.0, end: 7.0);

  @action
  void initAnimation(AnimationController controller) {
    animationShuffleController = controller;

    offsetAnimation = tweenForOffset
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(animationShuffleController!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationShuffleController!.reverse();
        }
      });
  }

  @action
  void disposeControllers() {
    animationShuffleController!.dispose();
  }
}
