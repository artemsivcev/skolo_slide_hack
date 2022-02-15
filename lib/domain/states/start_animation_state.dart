import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/domain/constants/dimensions.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';

part 'start_animation_state.g.dart';

class StartAnimationState = _StartAnimationState with _$StartAnimationState;

/// State is used for showing animation when the user starts the game.
abstract class _StartAnimationState with Store {
  /// Animation controller for start animation
  /// when user come to the screen at the first time.
  AnimationController? startAnimationController;

  /// animation for space between puzzle tiles.
  late Animation<double?> puzzleBoardAxisPaddingAnimation;

  /// animation for border radius of puzzle tiles.
  late Animation<double?> borderRadiusAnimation;

  late Animation<double?> flipAnimationPart1;

  late Animation<double?> flipAnimationPart2;

  /// tween for puzzle spacing
  final Tween<double> tweenForPuzzleSpacing = Tween<double>(
    begin: startPuzzleBoardAxisPadding,
    end: endPuzzleBoardAxisPadding,
  );

  /// tween for [borderRadiusAnimation]
  final Tween<double> tweenForBorderRadius = Tween<double>(
    begin: notInstalledTileCornerRadius,
    end: setTileCornerRadius,
  );

  /// tween for [flipAnimationPart1]
  final Tween<double> tweenFlipPart1 = Tween<double>(
    begin: 0,
    end: pi / 2,
  );

  /// tween for [flipAnimationPart2]
  final Tween<double> tweenFlipPart2 = Tween<double>(
    begin: pi,
    end: 0,
  );

  @observable
  double puzzlePadding = startPuzzleBoardAxisPadding;

  /// User enter to the screen at the first time.
  @observable
  bool isFirstScreenEntry = true;

  /// detect if start animation is completed
  @computed
  bool get isStartAnimationCompleted => startAnimationController != null
      ? startAnimationController!.status == AnimationStatus.completed
      : false;

  @observable
  bool isStartAnimPart1End = false;

  @observable
  bool isStartAnimPart2End = false;

  /// init the controller and animations
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

    puzzleBoardAxisPaddingAnimation = tweenForPuzzleSpacing.animate(
      CurvedAnimation(
        parent: startAnimationController!,
        curve: const Interval(
          0.0,
          0.2,
          curve: Curves.linear,
        ),
      ),
    );

    borderRadiusAnimation = tweenForBorderRadius.animate(
      CurvedAnimation(
        parent: startAnimationController!,
        curve: const Interval(
          0.2,
          0.5,
          curve: Curves.linear,
        ),
      ),
    );

    flipAnimationPart1 = tweenFlipPart1.animate(
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

    flipAnimationPart2 = tweenFlipPart2.animate(
      CurvedAnimation(
        parent: startAnimationController!,
        curve: const Interval(
          0.8,
          1,
          curve: Curves.linear,
        ),
      ),
    )..addListener(() {
        if (flipAnimationPart2.status == AnimationStatus.completed) {
          isStartAnimPart2End = true;
        }
      });
  }

  @action
  Future<void> startAnimation() async {
    await Future.delayed(animationOneSecondDuration);
    startAnimationController!.forward();
  }

  /// reset animation
  @action
  void resetStartAnimation() {
    startAnimationController?.reset();
    puzzlePadding = startPuzzleBoardAxisPadding;
    isFirstScreenEntry = false;
    isStartAnimPart1End = false;
    isStartAnimPart2End = false;
  }

  void dispose() {
    startAnimationController?.dispose();
    puzzlePadding = startPuzzleBoardAxisPadding;
    isFirstScreenEntry = false;
  }
}
