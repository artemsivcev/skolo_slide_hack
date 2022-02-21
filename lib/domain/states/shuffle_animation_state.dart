import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/sound_state.dart';
import 'package:skolo_slide_hack/domain/states/tile_animation_state.dart';

part 'shuffle_animation_state.g.dart';

class ShuffleAnimationState = _ShuffleAnimationState
    with _$ShuffleAnimationState;

/// State is used for showing animation when the user taps a shuffle button.
abstract class _ShuffleAnimationState with Store {
  TileAnimationState tileAnimationState = injector<TileAnimationState>();

  @observable
  AnimationController? animationController;

  /// animation for shaking puzzle tiles.
  @observable
  Animation<double>? shakeAnimation;

  /// animation for hiding and showing puzzle tiles.
  @observable
  Animation<double?>? appearDisappearAnimation;

  ///Tween for shaking puzzle board
  final Tween<double> tweenForShake = Tween(begin: 0.0, end: 7.0);

  /// init the controller and animations
  @action
  void initAnimation(AnimationController controller) {
    animationController = controller;

    shakeAnimation = tweenForShake
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(animationController!)
      ..addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          animationController!.reverse();
          await Future.delayed(const Duration(milliseconds: 690));
          tileAnimationState.currentAnimationPhase = TileAnimationPhase.NORMAL;
        }
      });

    appearDisappearAnimation = Tween<double>(
      begin: 35,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: const Interval(
          0.0,
          0.1,
          curve: Curves.bounceOut,
        ),
      ),
    );
  }

  /// function for pressing shuffle button and turning on the sound
  @action
  void shuffledPressed() {
    tileAnimationState.currentAnimationPhase = TileAnimationPhase.SHUFFLE;
    injector<SoundState>().playShuffleSound();
  }

  /// reset animation
  @action
  void resetAnimation() {
    animationController?.dispose();
  }
}
