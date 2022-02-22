import 'dart:ui';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/bird_eye_state.dart';

import 'custom_background_animation_behavior.dart';

class BackgroundWithBubbles extends StatefulWidget {
  const BackgroundWithBubbles({
    Key? key,
    required this.colorsBackground,
    required this.child,
    this.direction = LineDirection.Btt,
    this.numLines = 20,
    required this.opacity,
  }) : super(key: key);

  final Color colorsBackground;
  final Widget child;
  final LineDirection direction;
  final int numLines;
  final double opacity;

  @override
  _BackgroundWithBubblesState createState() => _BackgroundWithBubblesState();
}

class _BackgroundWithBubblesState extends State<BackgroundWithBubbles>
    with TickerProviderStateMixin {
  final birdEyeState = injector<BirdEyeState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.colorsBackground,
      body: MouseRegion(
        onExit: birdEyeState.resetEyesLocation,
        onHover: birdEyeState.updateEyesLocation,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedOpacity(
              opacity: widget.opacity,
              duration: const Duration(seconds: 3),
              child: AnimatedBackground(
                behaviour: CustomBackgroundAnimationBehaviour(
                    direction: widget.direction, numLines: widget.numLines),
                vsync: this,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 7.5,
                    sigmaY: 7.5,
                  ),
                  child: const SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                  ),
                ),
              ),
            ),
            widget.child,
          ],
        ),
      ),
    );
  }
}
