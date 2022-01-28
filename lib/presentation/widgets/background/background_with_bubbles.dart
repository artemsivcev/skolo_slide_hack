import 'dart:ui';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

import 'custom_background_animation_behavior.dart';

class BackgroundWithBubbles extends StatefulWidget {
  const BackgroundWithBubbles({
    Key? key,
    required this.colorsBackground,
    required this.child,
  }) : super(key: key);

  final Color colorsBackground;
  final Widget child;

  @override
  _BackgroundWithBubblesState createState() => _BackgroundWithBubblesState();
}

class _BackgroundWithBubblesState extends State<BackgroundWithBubbles>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.colorsBackground,
      body: AnimatedBackground(
        behaviour: CustomBackgroundAnimationBehaviour(),
        vsync: this,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 15.0,
            sigmaY: 15.0,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
