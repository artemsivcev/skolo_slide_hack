import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:skolo_slide_hack/domain/enums/corners_enum.dart';
import 'package:skolo_slide_hack/domain/models/position.dart';

/// Model for a puzzle tile.
class Tile extends Equatable {
  const Tile({
    required this.value,
    required this.correctPosition,
    required this.currentPosition,
    required this.corner,
    this.customImage,
    this.isEmpty = false,
  });

  /// Denotes the [Tile] value in the puzzle board
  final int value;

  /// The correct 2D [Position] of the [Tile]. All tiles must be in their
  /// correct position to complete the puzzle.
  final Position correctPosition;

  /// The current 2D [Position] of the [Tile].
  final Position currentPosition;

  /// Denotes if the [Tile] is the tile empty or not.
  final bool isEmpty;

  /// Custom image for [Tile] to render
  final Uint8List? customImage;

  /// Detects if tile is placed at the corner of board
  /// due its correct position
  final CornersEnum corner;

  /// Create a copy of this [Tile] with updated current position.
  Tile copyWith({required Position currentPosition}) {
    return Tile(
      value: value,
      correctPosition: correctPosition,
      currentPosition: currentPosition,
      isEmpty: isEmpty,
      customImage: customImage,
      corner: corner,
    );
  }

  @override
  List<Object> get props => [
        value,
        correctPosition,
        currentPosition,
        isEmpty,
        corner,
      ];
}
