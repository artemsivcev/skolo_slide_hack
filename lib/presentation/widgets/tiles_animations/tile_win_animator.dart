import 'dart:math';
import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/domain/enums/corners_enum.dart';
import 'package:skolo_slide_hack/domain/models/tile.dart';
import 'package:skolo_slide_hack/domain/states/win_animation_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/polymorphic_container.dart';

class TileWinAnimator extends StatelessWidget {
  final double tweenStart;
  final Widget child;
  final Tile tile;

  final winAnimationState = injector<WinAnimationState>();

  TileWinAnimator({
    Key? key,
    required this.child,
    required this.tweenStart,
    required this.tile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var corner = tile.corner;

    return Opacity(
      opacity: tile.isEmpty ? winAnimationState.fadeAnimation!.value : 1,
      child: AnimatedSwitcher(
        duration: animationOneAndHalfSecondDuration,
        transitionBuilder: transitionBuilder,
        child: winAnimationState.isAnimCompleted
            ? Container(
                color: Colors.transparent,
                child: PolymorphicContainer(
                  userInnerStyle: false,
                  innerShadowBorderRadius: 0,
                  topLeftCorner: corner == CornersEnum.topLeftCorner,
                  bottomLeftCorner: corner == CornersEnum.bottomLeftCorner,
                  bottomRightCorner: corner == CornersEnum.bottomRightCorner,
                  topRightCorner: corner == CornersEnum.topRightCorner,
                  child: tile.customImage == null ? Container() : child,
                ),
              )
            : PolymorphicContainer(
                userInnerStyle: false,
                child: child,
              ),
      ),
    );
  }

  Widget transitionBuilder(Widget widget, Animation<double> animation) {
    final flipAnim = winAnimationState.tweenForFlipping.animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(tweenStart, 1),
      ),
    );

    return AnimatedBuilder(
      animation: flipAnim,
      child: widget,
      builder: (context, widget) {
        final value = winAnimationState.isAnimCompleted
            ? min(flipAnim.value, pi / 2)
            : flipAnim.value;

        return Transform(
          transform: Matrix4.rotationY(value),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }
}
