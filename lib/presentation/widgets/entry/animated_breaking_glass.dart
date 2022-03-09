import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/screen_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/entry/triangle_clipper.dart';
import 'package:skolo_slide_hack/presentation/widgets/entry/triangle_painter.dart';

class AnimatedBreakingGlass extends StatelessWidget {
  /// progress value of animation
  final double progress;

  /// points of triangles
  final List<Offset> points;
  final Widget child;

  /// multipliers for fly direction
  final double multipleX;
  final double multipleY;

  final screenState = injector<ScreenState>();

  AnimatedBreakingGlass({
    Key? key,
    required this.progress,
    required this.points,
    required this.child,
    this.multipleX = 0.12,
    this.multipleY = 1.1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// find the centroid of triangle
    final centroid = Offset(
      (points[0].dx + points[1].dx + points[2].dx) / 3.0,
      (points[0].dy + points[1].dy + points[2].dy) / 3.0,
    );

    /// offset in x-axis influence the direction of animated parts
    /// if triangles are located in the left part of the screen, they
    /// fly at this direction. The same happens with right aligned parts.
    /// The middle ones fly just at the bottom direction
    var signX = centroid.dx < 0.2
        ? -1
        : centroid.dx > 0.8
            ? 1
            : 0;

    final alignment = Alignment(-1 + centroid.dx * 2, -1 + centroid.dy * 2);

    return LayoutBuilder(
      builder: (context, constraints) => Transform.translate(
        offset: Offset(signX * progress * constraints.maxWidth * multipleX,
            progress * constraints.maxHeight * multipleY),
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.01)
            ..rotateZ((alignment.x < 0 ? -1 : 1) * 0.7 * progress)
            ..rotateX((alignment.x < 0 ? -1 : 1) * 0.6 * progress)
            ..rotateY((alignment.x < 0 ? -1 : 1) * 0.6 * progress),
          alignment: alignment,
          child: Transform.scale(
            scale: 1 - 0.7 * progress,
            alignment: alignment,
            child: CustomPaint(
              painter: TrianglePainter(points: points),
              child: ClipPath(
                clipper: TriangleClipper(points: points),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
