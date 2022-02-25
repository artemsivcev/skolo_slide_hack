import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';
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

  @override
  Widget build(BuildContext context) {
    final colorToUse = widget.isButtonActive
        ? colorsPurpleBluePrimary
        : colorsPurpleBluePrimaryLight;

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
        width: widget.buttonSize,
        height: widget.buttonSize,
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
                  color: colorToUse,
                  height: 40,
                ),
              ),
              Center(
                child: CircularText(
                  children: [
                    TextItem(
                      space: 15.0,
                      startAngle: -60.0,
                      text: Text(
                        'Long press to shuffle',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 40.0,
                          fontWeight: FontWeight.w900,
                          color: colorToUse,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
