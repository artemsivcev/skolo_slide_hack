import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';
import 'package:skolo_slide_hack/domain/states/screen_state.dart';
import 'package:skolo_slide_hack/domain/states/shuffle_animation_state.dart';

class RotatedShuffleButton extends StatefulWidget {
  const RotatedShuffleButton({
    Key? key,
    required this.isButtonActive,
    this.buttonSize = 100.0,
  }) : super(key: key);

  final bool isButtonActive;

  final double buttonSize;

  @override
  State<RotatedShuffleButton> createState() => _RotatedShuffleButtonState();
}

class _RotatedShuffleButtonState extends State<RotatedShuffleButton> {
  final shuffleAnimationState = injector<ShuffleAnimationState>();
  final puzzleState = injector<PuzzleState>();

  final screenState = injector<ScreenState>();

  @override
  Widget build(BuildContext context) {
    final colorToUse = widget.isButtonActive
        ? colorsPurpleBluePrimary
        : colorsPurpleBluePrimaryLight;
    var usedMobileVersion = screenState.usedMobileVersion;

    return GestureDetector(
      onLongPress: () {
        if (shuffleAnimationState.shuffleBtnRotationAnimation!.status ==
                AnimationStatus.dismissed &&
            shuffleAnimationState.shuffleBtnRotationAnimation!.status !=
                AnimationStatus.completed &&
            widget.isButtonActive) {
          shuffleAnimationState.shuffleBtnAnimationController!
              .forward()
              .then((value) async {
            shuffleAnimationState.shuffledPressed();
            shuffleAnimationState.animationController!.forward();
            await puzzleState.shuffleButtonTap();
          });
        }
      },
      onLongPressEnd: (_) {
        shuffleAnimationState.shuffleBtnAnimationController!.reverse();
      },
      //Increase gesture area by the SizedBox
      child: SizedBox(
        child: AnimatedBuilder(
          animation: shuffleAnimationState.shuffleBtnRotationAnimation!,
          builder: (_, child) {
            return Transform.rotate(
              angle: -shuffleAnimationState.shuffleBtnRotationAnimation!.value,
              child: child!,
            );
          },
          child: Stack(
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/images/restart.svg',
                  color: colorsPurpleBluePrimary,
                  height: usedMobileVersion ? 26 : 34,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
