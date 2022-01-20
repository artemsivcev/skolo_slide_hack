import 'package:equatable/equatable.dart';

/// 2-dimensional position model.
class Position extends Equatable implements Comparable<Position> {
  const Position({required this.x, required this.y});

  /// The x position.
  final int x;

  /// The y position.
  final int y;

  @override
  List<Object> get props => [x, y];

  /// difference (delta) between x-coordinate position
  int deltaX(Position other) => x - other.x;

  /// difference (delta) between y-coordinate position
  int deltaY(Position other) => y - other.y;

  /// comparing given positions due to their x and y coordinates
  @override
  int compareTo(Position other) {
    if (y < other.y) {
      return -1;
    } else if (y > other.y) {
      return 1;
    } else if (x < other.x) {
      return -1;
    } else if (x > other.x) {
      return 1;
    } else {
      return 0;
    }
  }
}
