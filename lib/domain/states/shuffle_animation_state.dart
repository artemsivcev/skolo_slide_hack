import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/sound_state.dart';

part 'shuffle_animation_state.g.dart';

class ShuffleAnimationState = _ShuffleAnimationState
    with _$ShuffleAnimationState;

abstract class _ShuffleAnimationState with Store {
  @observable
  AnimationController? animationShuffleController;

  @observable
  Animation<double>? shakeAnimation;

  @observable
  Animation<double?>? appearDisappearAnimation;

  @observable
  bool shuffled = false;

  ///Tween for shaking puzzle board
  final Tween<double> tweenForShake = Tween(begin: 0.0, end: 7.0);

  @action
  void initAnimation(AnimationController controller) {
    animationShuffleController = controller;

    shakeAnimation = tweenForShake
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(animationShuffleController!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationShuffleController!.reverse();
          shuffled = false;
        }
      });

    appearDisappearAnimation = Tween<double>(
      begin: 35,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: animationShuffleController!,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.bounceOut,
        ),
      ),
    );
  }

  @action
  void shuffledPressed() {
    injector<SoundState>().playShuffleSound();
    shuffled = true;
  }

  void dispose() {
    animationShuffleController?.dispose();
    shuffled = false;
  }
}
