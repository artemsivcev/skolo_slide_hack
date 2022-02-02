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

  late Tween<double> puzzleSpacingTween;

  @observable
  double puzzlePadding = startPuzzleBoardAxisPadding;

  /// User enter to the screen at the first time.
  @observable
  bool isFirstScreenEntry = true;

  initStartAnimationController(TickerProvider tickerProvider) {
    print('init Start animation Controller');
    startAnimationController = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(
        milliseconds: startShiftTilesAnimationDuration +
            startBorderCornerAnimationDuration,
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
          0.5,
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
          0.5,
          1,
          curve: Curves.linear,
        ),
      ),
    );
  }

  @action
  void resetStartAnimation() {
    startAnimationController?.reset();
    puzzlePadding = startPuzzleBoardAxisPadding;
    isFirstScreenEntry = false;
  }

  void dispose() {
    startAnimationController?.dispose();
    puzzlePadding = startPuzzleBoardAxisPadding;
    isFirstScreenEntry = false;
  }
}
