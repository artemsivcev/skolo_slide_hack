import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/start_animation_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/polymorphic_container_pure.dart';

class TileStartAnimator extends StatelessWidget {
  final _startAnimation = injector<StartAnimationState>();

  final Widget child;

  TileStartAnimator({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationX(_startAnimation.flipAnimation.value!),
      child: PolymorphicContainerPure(
        externalBorderRadius: _startAnimation.borderRadiusAnimation.value!,
        child: child,
      ),
    );
  }
}
