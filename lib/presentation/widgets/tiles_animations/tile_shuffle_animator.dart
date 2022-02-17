import 'dart:math';
import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/domain/enums/corners_enum.dart';
import 'package:skolo_slide_hack/domain/models/tile.dart';
import 'package:skolo_slide_hack/domain/states/shuffle_animation_state.dart';
import 'package:skolo_slide_hack/domain/states/win_animation_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/polymorphic_container_pure.dart';

class TileShuffleAnimator extends StatelessWidget {
  final Widget child;

  final shuffleAnimationState = injector<ShuffleAnimationState>();

  TileShuffleAnimator({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: animationOneSecondDuration,
      padding: EdgeInsets.all(shuffleAnimationState.shuffled
          ? shuffleAnimationState.appearDisappearAnimation!.value!
          : 2.0),
      child: PolymorphicContainerPure(
        userInnerStyle: false,
        child: child,
      ),
    );
  }
}
