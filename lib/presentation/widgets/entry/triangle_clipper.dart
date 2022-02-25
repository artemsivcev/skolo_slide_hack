import 'package:flutter/material.dart';

/// [TriangleClipper] is used for clipping the screen
/// due to given points of triangles [Triangle]
class TriangleClipper extends CustomClipper<Path> {
  final List<Offset> points;

  TriangleClipper({required this.points});

  @override
  Path getClip(Size size) {
    return Path()
      ..addPolygon(
          points
              .map(
                (relOffset) => Offset(
                    relOffset.dx * size.width, relOffset.dy * size.height),
              )
              .toList(),
          true);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
