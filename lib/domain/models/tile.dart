import 'package:equatable/equatable.dart';
import 'package:skolo_slide_hack/domain/models/position.dart';

/// Model for a puzzle tile.
class Tile extends Equatable {
  const Tile({
    required this.value,
    required this.correctPosition,
    required this.currentPosition,
    this.isWhitespace = false,
  });

  /// Denotes the [Tile] current position in the puzzle board
  final int value;

  /// The correct 2D [Position] of the [Tile]. All tiles must be in their
  /// correct position to complete the puzzle.
  final Position correctPosition;

  /// The current 2D [Position] of the [Tile].
  final Position currentPosition;

  /// Denotes if the [Tile] is the whitespace tile or not.
  final bool isWhitespace;

  /// Create a copy of this [Tile] with updated current position.
  Tile copyWith({required Position currentPosition}) {
    return Tile(
      value: value,
      correctPosition: correctPosition,
      currentPosition: currentPosition,
      isWhitespace: isWhitespace,
    );
  }

  @override
  List<Object> get props => [
        value,
        correctPosition,
        currentPosition,
        isWhitespace,
      ];
}
