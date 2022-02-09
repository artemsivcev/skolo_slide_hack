import 'dart:ui';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/new_game_state.dart';

import 'custom_background_animation_behavior.dart';

class BackgroundWithBubbles extends StatefulWidget {
  const BackgroundWithBubbles({
    Key? key,
    required this.colorsBackground,
    required this.child,
    this.direction = LineDirection.Btt,
  }) : super(key: key);

  final Color colorsBackground;
  final Widget child;
  final LineDirection direction;

  @override
  _BackgroundWithBubblesState createState() => _BackgroundWithBubblesState();
}

class _BackgroundWithBubblesState extends State<BackgroundWithBubbles>
    with TickerProviderStateMixin {
  final newGameState = injector<NewGameState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.colorsBackground,
      body: Builder(builder: (context) {
        newGameState.setScreenSize(context);
        return MouseRegion(
          onExit: newGameState.resetEyesLocation,
          onHover: newGameState.updateEyesLocation,
          child: AnimatedBackground(
            behaviour:
                CustomBackgroundAnimationBehaviour(direction: widget.direction),
            vsync: this,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 7.5,
                sigmaY: 7.5,
              ),
              child: widget.child,
            ),
          ),
        );
      }),
    );
  }
}
