import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/domain/constants/dimensions.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';

part 'start_animation_state.g.dart';

class StartAnimationState = _StartAnimationState with _$StartAnimationState;

abstract class _StartAnimationState with Store {
  /// Animation controller for start animation
  /// when user come to the screen at the first time.
  AnimationController? startAnimationController;

  late Animation<double?> puzzleBoardAxisPaddingAnimation;

  late Animation<double?> borderRadiusAnimation;

  late Animation<double?> flipAnimation;

  late Tween<double> puzzleSpacingTween;

  @observable
  double puzzlePadding = startPuzzleBoardAxisPadding;

  /// User enter to the screen at the first time.
  @observable
  bool isFirstScreenEntry = true;

  @computed
  bool get isStartAnimationCompleted => startAnimationController != null
      ? startAnimationController!.status == AnimationStatus.completed
      : false;

  @observable
  bool needShowCorrectTile = true;

  initStartAnimationController(TickerProvider tickerProvider) {
    startAnimationController = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(
        milliseconds: startShiftTilesAnimationDuration +
            startBorderCornerAnimationDuration +
            startFlipAnimationDuration,
      ),
    )..addListener(() {
        if (startAnimationController!.status == AnimationStatus.completed) {
          isFirstScreenEntry = false;
        }

        puzzlePadding = puzzleBoardAxisPaddingAnimation.value ??
            startPuzzleBoardAxisPadding;
      });

    puzzleSpacingTween = Tween<double>(
      begin: startPuzzleBoardAxisPadding,
      end: endPuzzleBoardAxisPadding,
    );

    puzzleBoardAxisPaddingAnimation = puzzleSpacingTween.animate(
      CurvedAnimation(
        parent: startAnimationController!,
        curve: const Interval(
          0.0,
          0.2,
          curve: Curves.linear,
        ),
      ),
    );

    borderRadiusAnimation = Tween<double>(
      begin: notInstalledTileCornerRadius,
      end: setTileCornerRadius,
    ).animate(
      CurvedAnimation(
        parent: startAnimationController!,
        curve: const Interval(
          0.2,
          0.5,
          curve: Curves.linear,
        ),
      ),
    );

    print("Target flip value: ${pi / 2}");

    flipAnimation = Tween<double>(
      begin: pi,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: startAnimationController!,
        curve: const Interval(
          0.5,
          1,
          curve: Curves.linear,
        ),
      ),
    )..addListener(() {
        print('flipAnimation value: ${flipAnimation.value!.floor()}');
        if (needShowCorrectTile && flipAnimation.value!.floor() == 1) {
          print("Now!");
          needShowCorrectTile = false;
        }
      });
  }

  @action
  void resetStartAnimation() {
    startAnimationController?.reset();
    puzzlePadding = startPuzzleBoardAxisPadding;
    isFirstScreenEntry = false;
    needShowCorrectTile = true;
  }

  void dispose() {
    startAnimationController?.dispose();
    puzzlePadding = startPuzzleBoardAxisPadding;
    isFirstScreenEntry = false;
  }
}
