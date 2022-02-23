import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';

/// [TrianglePainter] is used for adding colored border to the given points
/// of triangles [Triangle]. Its path must be equal to the path of [TriangleClipper]
class TrianglePainter extends CustomPainter {
  final List<Offset> points;
  TrianglePainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = colorsBackgroundMenu;

    Path path = Path()
      ..addPolygon(
          points
              .map(
                (relOffset) => Offset(
                    relOffset.dx * size.width, relOffset.dy * size.height),
              )
              .toList(),
          true);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
