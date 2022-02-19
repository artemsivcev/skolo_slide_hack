import 'dart:math';
import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/domain/enums/corners_enum.dart';
import 'package:skolo_slide_hack/domain/models/tile.dart';
import 'package:skolo_slide_hack/domain/states/shuffle_animation_state.dart';
import 'package:skolo_slide_hack/domain/states/win_animation_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/polymorphic_container_pure.dart';

class BoardShuffleAnimator extends StatelessWidget {
  final Widget child;

  final shuffleAnimationState = injector<ShuffleAnimationState>();

  BoardShuffleAnimator({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sineValue =
        sin(3 * 2 * pi * shuffleAnimationState.animationController!.value);
    return Transform.translate(
      // 4. apply a translation as a function of the animation value
      offset: Offset(sineValue * 9, 0),
      // 5. use the child widget
      child: child,
    );
  }
}
