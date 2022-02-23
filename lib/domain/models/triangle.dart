import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Triangle with three points (using offset)
class Triangle extends Equatable {
  /// first point
  final Offset point1;

  /// second point
  final Offset point2;

  /// third point
  final Offset point3;

  final random = Random();

  Triangle(this.point1, this.point2, this.point3);

  /// method gives the ability to divide triangle using its centroid.
  /// The centroid of a triangle is the intersection of its three medians
  /// (each median connecting a vertex with the midpoint of the opposite side).
  List<Triangle> divide() {
    final midPoint12 = getMidpoint(point1, point2);
    final midPoint23 = getMidpoint(point2, point3);
    final midPoint13 = getMidpoint(point1, point3);
    final centroid = getCentroid;

    return [
      Triangle(point1, midPoint12, centroid),
      Triangle(midPoint12, point2, centroid),
      Triangle(point2, midPoint23, centroid),
      Triangle(midPoint23, point3, centroid),
      Triangle(point3, midPoint13, centroid),
      Triangle(midPoint13, point1, centroid),
    ];
  }

  /// get the midpoint of the side
  Offset getMidpoint(Offset p1, Offset p2) => Offset(
        (p1.dx + p2.dx) * 0.5,
        (p1.dy + p2.dy) * 0.5,
      );

  /// get the centroid
  Offset get getCentroid => Offset(
        (point1.dx + point2.dx + point3.dx) / 3.0,
        (point1.dy + point2.dy + point3.dy) / 3.0,
      );

  @override
  List<Offset> get props => [point1, point2, point3];
}
