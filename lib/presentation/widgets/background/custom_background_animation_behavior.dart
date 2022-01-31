import 'dart:math' as math;

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

/// Holds the information of a line used in a [CustomBackgroundAnimationBehaviour].
class Line {
  /// The position of the start of this line.
  Offset? position;

  /// The speed of this line.
  late double speed;

  /// The radius of this bubble.
  double? radius;

  /// The color of this line.
  Color? color;
}

/// Renders moving lines on an [AnimatedBackground].
class CustomBackgroundAnimationBehaviour extends Behaviour {
  static final math.Random random = math.Random();

  /// Creates a new racing lines behaviour
  CustomBackgroundAnimationBehaviour(
      {this.direction = LineDirection.Btt, int numLines = 20})
      : assert(numLines >= 0) {
    _numLines = numLines;
  }

  /// The list of lines used by the behaviour to hold the spawned lines.
  @protected
  List<Line>? lines;

  int? _numLines;

  /// Gets the number of lines in the background.
  int? get numLines => _numLines;

  /// Sets the number of lines in the background.
  set numLines(value) {
    if (isInitialized) {
      if (value > lines!.length) {
        lines!.addAll(generateLines(value - lines!.length));
      } else if (value < lines!.length) {
        lines!.removeRange(0, lines!.length - value as int);
      }
    }
    _numLines = value;
  }

  /// The direction in which the lines should move
  ///
  /// Changing this will cause all lines to move in this direction, but no
  /// animation will be performed to change the direction. The lines will
  @protected
  LineDirection direction;

  /// Generates an amount of lines and initializes them.
  @protected
  List<Line> generateLines(int numLines) => List<Line>.generate(numLines, (i) {
        final Line line = Line();
        initLine(line);
        return line;
      });

  /// Initializes a line for this behaviour.
  @protected
  void initLine(Line line) {
    line.speed = random.nextDouble() * 100;

    final bool axisHorizontal =
        (direction == LineDirection.Ltr || direction == LineDirection.Rtl);
    final bool normalDirection =
        (direction == LineDirection.Ltr || direction == LineDirection.Ttb);
    final double sizeCrossAxis = axisHorizontal ? size!.height : size!.width;
    final double sizeMainAxis = axisHorizontal ? size!.width : size!.height;
    final double spawnCrossAxis = random.nextInt(100) * (sizeCrossAxis / 100);
    double spawnMainAxis = 0.0;

    if (line.position == null) {
      spawnMainAxis = random.nextDouble() * sizeMainAxis;
    } else {
      spawnMainAxis = normalDirection
          ? (-line.speed / 2.0)
          : (sizeMainAxis + line.speed / 2.0);
    }

    line.position = axisHorizontal
        ? Offset(spawnMainAxis, spawnCrossAxis)
        : Offset(spawnCrossAxis, spawnMainAxis);

    /// The minimum radius a bubble should grow to before popping.
    const double minTargetRadius = 50.0;

    /// The maximum radius a bubble should grow to.
    const double maxTargetRadius = 100.0;

    var deltaTargetRadius = maxTargetRadius - minTargetRadius;
    var targetRadius =
        random.nextDouble() * deltaTargetRadius + minTargetRadius;
    line.radius = random.nextDouble() * targetRadius;
    line.color = Colors.white;
  }

  @override
  void init() {
    lines = generateLines(numLines!);
  }

  @override
  void initFrom(Behaviour oldBehaviour) {
    if (oldBehaviour is CustomBackgroundAnimationBehaviour) {
      lines = oldBehaviour.lines;
      numLines = _numLines; // causes the lines to update
    }
  }

  @override
  bool get isInitialized => lines != null;

  @override
  void paint(PaintingContext context, Offset offset) {
    Canvas canvas = context.canvas;
    Paint paint = Paint()..strokeCap = StrokeCap.round;
    for (var line in lines!) {
      paint.color = line.color!;
      canvas.drawCircle(line.position!, line.radius!, paint);
    }
  }

  @override
  bool tick(double delta, Duration elapsed) {
    final bool axisHorizontal =
        (direction == LineDirection.Ltr || direction == LineDirection.Rtl);
    final int sign =
        (direction == LineDirection.Ltr || direction == LineDirection.Ttb)
            ? 1
            : -1;
    if (axisHorizontal) {
      for (var line in lines!) {
        line.position =
            line.position!.translate(delta * line.speed * sign, 0.0);
        if ((direction == LineDirection.Ltr &&
                line.position!.dx > size!.width) ||
            (direction == LineDirection.Rtl && line.position!.dx < 0)) {
          initLine(line);
        }
      }
    } else {
      for (var line in lines!) {
        line.position =
            line.position!.translate(0.0, delta * line.speed * sign);
        if ((direction == LineDirection.Ttb &&
                line.position!.dy > size!.height) ||
            (direction == LineDirection.Btt && line.position!.dy < 0)) {
          initLine(line);
        }
      }
    }
    return true;
  }
}
