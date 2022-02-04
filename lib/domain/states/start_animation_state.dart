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

  late Animation<double?> flipAnimationPart1;

  late Animation<double?> flipAnimationPart2;

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
  bool isStartAnimPart1End = false;

  @observable
  bool isStartAnimPart2End = false;

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

    flipAnimationPart1 = Tween<double>(
      begin: 0,
      end: pi / 2,
    ).animate(
      CurvedAnimation(
        parent: startAnimationController!,
        curve: const Interval(
          0.5,
          0.8,
          curve: Curves.linear,
        ),
      ),
    )..addListener(() {
        if (flipAnimationPart1.status == AnimationStatus.completed) {
          isStartAnimPart1End = true;
        }
      });

    flipAnimationPart2 = Tween<double>(
      begin: pi,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: startAnimationController!,
        curve: const Interval(
          0.8,
          1,
          curve: Curves.linear,
        ),
      ),
    )..addListener(() {
        print("flipAnimationPart2: ${flipAnimationPart2.value}");
        if (flipAnimationPart2.status == AnimationStatus.completed) {
          isStartAnimPart2End = true;
        }
      });
  }

  @action
  void resetStartAnimation() {
    startAnimationController?.reset();
    puzzlePadding = startPuzzleBoardAxisPadding;
    isFirstScreenEntry = false;
    isStartAnimPart1End = false;
  }

  void dispose() {
    startAnimationController?.dispose();
    puzzlePadding = startPuzzleBoardAxisPadding;
    isFirstScreenEntry = false;
  }
}
