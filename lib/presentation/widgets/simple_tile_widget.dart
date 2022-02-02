import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/domain/constants/text_styles.dart';
import 'package:skolo_slide_hack/domain/enums/corners_enum.dart';
import 'package:skolo_slide_hack/domain/models/tile.dart';
import 'package:skolo_slide_hack/domain/states/start_animation_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/polymorphic_container.dart';

/// [SimpleTileWidget] stands for one tile widget.
/// Depending on the condition if tile is empty or not
/// need to show coloured container or empty sizedBox
class SimpleTileWidget extends StatelessWidget {
  const SimpleTileWidget({
    Key? key,
    required this.tile,
    required this.onTap,
    required this.isComplete,
    required this.tweenStart,
    required this.tween,
    required this.fadeAnimation,
  }) : super(key: key);

  final Tile tile;
  final VoidCallback onTap;
  final bool isComplete;
  final double tweenStart;
  final Tween<double> tween;

  final Animation<double> fadeAnimation;

  @override
  Widget build(BuildContext context) {
    return tile.isEmpty
        ? FadeTransition(
            opacity: fadeAnimation,
            child: AnimatedWidget(
              tweenStart: tweenStart,
              tween: tween,
              isComplete: isComplete,
              onTap: null,
              tile: tile,
            ),
          )
        : AnimatedWidget(
            tweenStart: tweenStart,
            tween: tween,
            isComplete: isComplete,
            onTap: onTap,
            tile: tile,
          );
  }
}

class AnimatedWidget extends StatelessWidget {
  AnimatedWidget({
    Key? key,
    required this.tile,
    this.onTap,
    required this.isComplete,
    required this.tweenStart,
    required this.tween,
  }) : super(key: key);

  final Tile tile;
  final VoidCallback? onTap;
  final bool isComplete;
  final double tweenStart;
  final Tween<double> tween;
  final _startAnimation = injector<StartAnimationState>();

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
        duration: animationOneThirdSecondDuration,
        transitionBuilder: transitionBuilder,
        child: isComplete
            //win case tile
            ? PolymorphicContainer(
                userInnerStyle: false,
                innerShadowBorderRadius: 0,
                isTopLeftCorner: tile.corner == CornersEnum.topLeftCorner,
                isBottomLeftCorner: tile.corner == CornersEnum.bottomLeftCorner,
                isBottomRightCorner:
                    tile.corner == CornersEnum.bottomRightCorner,
                isTopRightCorner: tile.corner == CornersEnum.topRightCorner,
                child: Center(
                  child: tile.customImage != null
                      ? Image.memory(tile.customImage!)
                      : Container(),
                ),
              )
            // usual tile
            : InkWell(
                onTap: onTap,
                child: AnimatedBuilder(
                  animation: _startAnimation.borderRadiusAnimation,
                  builder: (_, builderChild) {
                    return PolymorphicContainer(
                      duration: const Duration(seconds: 0),
                      userInnerStyle: false,
                      externalBorderRadius:
                          _startAnimation.borderRadiusAnimation.value!,
                      child: builderChild!,
                    );
                  },
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        tile.customImage != null
                            ? Image.memory(tile.customImage!)
                            : Container(),
                        Text(
                          '${tile.value}',
                          style: numberTextStyle.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      );

  Widget transitionBuilder(Widget widget, Animation<double> animation) {
    final flipAnim = tween.animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(tweenStart, 1),
      ),
    );

    return AnimatedBuilder(
      animation: flipAnim,
      child: widget,
      builder: (context, widget) {
        final value = isComplete ? min(flipAnim.value, pi / 2) : flipAnim.value;

        return Transform(
          transform: Matrix4.rotationY(value),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }
}
