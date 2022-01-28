import 'package:flutter/material.dart';

class StartAnimation {
  /// Animation controller for start animation
  /// when user come to the screen at the first time.
  late AnimationController startAnimationController;

  StartAnimation(TickerProvider tickerProvider) {
    startAnimationController = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
  }
}
