import 'dart:math';

import 'package:flutter/material.dart';

class TextShadows {
  //logic for text shadows
  static List<Shadow> generateLongShadow() {
    const int numSteps = 10;
    const double opacityConf = 0.3;
    const double opacityPow = 1.0;
    const double offset = 0.5;
    const double offsetPow = 2.0;
    const double blur = 100;
    const double blurPow = 1;
    const Color shadowColor = Colors.black;
    const Point position = Point(-100.0, -100.0);
    const double intensity = 1.0;

    double distance = sqrt(position.x * position.x + position.y * position.y);
    distance = max(32, distance);

    List<Shadow> shadows = List<Shadow>.generate(numSteps, (int index) {
      double ratio = index / numSteps;

      var ratioOpacity = pow(ratio, opacityPow);
      var ratioOffset = pow(ratio, offsetPow);
      var ratioBlur = pow(ratio, blurPow);

      double opacity = intensity * max(0, opacityConf * (1.0 - ratioOpacity));
      double offsetX = -offset * position.x * ratioOffset;
      double offsetY = -offset * position.y * ratioOffset;
      double blurRadius = distance * blur * ratioBlur / 512;

      return _getShadow(shadowColor, opacity, offsetX, offsetY, blurRadius);
    });

    return shadows;
  }

  static Shadow _getShadow(Color shadowRGB, double opacity, double offsetX,
      double offsetY, double blurRadius) {
    return Shadow(
      blurRadius: blurRadius,
      color: shadowRGB.withOpacity(opacity),
      offset: Offset(offsetX, offsetY),
    );
  }
}
