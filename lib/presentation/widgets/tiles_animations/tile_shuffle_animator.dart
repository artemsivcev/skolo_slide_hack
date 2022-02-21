import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/shuffle_animation_state.dart';
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
      duration: const Duration(milliseconds: 800),
      padding: EdgeInsets.all(
          shuffleAnimationState.appearDisappearAnimation!.value!),
      child: PolymorphicContainerPure(
        userInnerStyle: false,
        child: child,
      ),
    );
  }
}
