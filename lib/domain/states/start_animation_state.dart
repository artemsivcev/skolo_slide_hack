import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/dimensions.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/domain/states/tile_animation_state.dart';

part 'start_animation_state.g.dart';

class StartAnimationState = _StartAnimationState with _$StartAnimationState;

/// State is used for showing animation when the user starts the game.
abstract class _StartAnimationState with Store {
  TileAnimationState tileAnimationState = injector<TileAnimationState>();

  /// Animation controller for start animation
  /// when user come to the screen at the first time.
  AnimationController? animationController;

  /// animation for space between puzzle tiles.
  late Animation<double?> puzzleBoardAxisPaddingAnimation;

  /// animation for border radius of puzzle tiles.
  late Animation<double?> borderRadiusAnimation;

  late Animation<double?> flipAnimation;

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

  /// tween for [flipAnimation]
  final Tween<double> tweenFlip = Tween<double>(
    begin: 0,
    end: pi / 2,
  );

  @observable
  double puzzlePadding = startPuzzleBoardAxisPadding;

  @observable
  bool isStartAnimBorderEnd = false;

  @observable
  bool isStartAnimEnd = false;

  /// init the controller and animations
  initStartAnimationController(TickerProvider tickerProvider) {
    animationController = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(
        milliseconds: startShiftTilesAnimationDuration +
            startBorderCornerAnimationDuration +
            startFlipAnimationDuration,
      ),
    )..addListener(() {
        if (animationController!.status == AnimationStatus.completed) {
          tileAnimationState.currentAnimationPhase = TileAnimationPhase.NORMAL;
        }

        puzzlePadding = puzzleBoardAxisPaddingAnimation.value ??
            startPuzzleBoardAxisPadding;
      });

    puzzleBoardAxisPaddingAnimation = tweenForPuzzleSpacing.animate(
      CurvedAnimation(
        parent: animationController!,
        curve: const Interval(
          0.0,
          0.1,
          curve: Curves.linear,
        ),
      ),
    );

    borderRadiusAnimation = tweenForBorderRadius.animate(
      CurvedAnimation(
        parent: animationController!,
        curve: const Interval(
          0.1,
          0.6,
          curve: Curves.linear,
        ),
      ),
    )..addListener(() {
        if (borderRadiusAnimation.status == AnimationStatus.completed) {
          isStartAnimBorderEnd = true;
        }
      });

    flipAnimation = tweenFlip.animate(
      CurvedAnimation(
        parent: animationController!,
        curve: const Interval(
          0.6,
          0.8,
          curve: Curves.linear,
        ),
      ),
    )..addListener(() {
        if (flipAnimation.status == AnimationStatus.completed) {
          isStartAnimEnd = true;
        }
      });
  }

  @action
  Future<void> startAnimation() async {
    await Future.delayed(animationOneSecondDuration);
    animationController!.forward();
  }

  /// reset animation
  @action
  void resetStartAnimation() {
    animationController?.reset();
    puzzlePadding = startPuzzleBoardAxisPadding;
    isStartAnimEnd = false;
    isStartAnimBorderEnd = false;
  }

  void dispose() {
    animationController?.dispose();
    puzzlePadding = startPuzzleBoardAxisPadding;
  }
}
