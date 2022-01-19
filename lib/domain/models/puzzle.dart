import 'package:equatable/equatable.dart';
import 'package:skolo_slide_hack/domain/models/tile.dart';

/// Model for a puzzle.
class Puzzle extends Equatable {
  const Puzzle({required this.tiles});

  /// List of [Tile]s representing the puzzle's current arrangement.
  final List<Tile> tiles;

  /// Get the single whitespace tile object in the puzzle.
  Tile get getWhitespaceTile => tiles.singleWhere((tile) => tile.isWhitespace);

  /// Determines if the tapped tile can move in the direction of the whitespace tile.
  bool isTileMovable(Tile tile) {
    final whitespaceTile = getWhitespaceTile;
    if (tile == whitespaceTile) {
      return false;
    }

    // A tile must be in the same row or column as the whitespace to move.
    if (whitespaceTile.currentPosition.x != tile.currentPosition.x &&
        whitespaceTile.currentPosition.y != tile.currentPosition.y) {
      return false;
    }
    return true;
  }

  /// Shifts one or many tiles in a row/column with the whitespace and returns the modified puzzle.
  /// Recursively stores a list of all tiles that need to be moved and passes the
  /// list to _swapTiles to individually swap them.
  Puzzle moveTiles(Tile tile, List<Tile> tilesToSwap) {
    final whitespaceTile = getWhitespaceTile;
    final deltaX = whitespaceTile.currentPosition.x - tile.currentPosition.x;
    final deltaY = whitespaceTile.currentPosition.y - tile.currentPosition.y;

    if ((deltaX.abs() + deltaY.abs()) > 1) {
      final shiftPointX = tile.currentPosition.x + deltaX.sign;
      final shiftPointY = tile.currentPosition.y + deltaY.sign;
      final tileToSwapWith = tiles.singleWhere(
        (tile) =>
            tile.currentPosition.x == shiftPointX &&
            tile.currentPosition.y == shiftPointY,
      );
      tilesToSwap.add(tile);
      return moveTiles(tileToSwapWith, tilesToSwap);
    } else {
      tilesToSwap.add(tile);
      return _swapTiles(tilesToSwap);
    }
  }

  /// Returns puzzle with new tile arrangement after individually swapping each
  /// tile in tilesToSwap with the whitespace.
  Puzzle _swapTiles(List<Tile> tilesToSwap) {
    for (final tileToSwap in tilesToSwap.reversed) {
      final tileIndex = tiles.indexOf(tileToSwap);
      final tile = tiles[tileIndex];
      final whitespaceTile = getWhitespaceTile;
      final whitespaceTileIndex = tiles.indexOf(whitespaceTile);

      // Swap current board positions of the moving tile and the whitespace.
      tiles[tileIndex] = tile.copyWith(
        currentPosition: whitespaceTile.currentPosition,
      );
      tiles[whitespaceTileIndex] = whitespaceTile.copyWith(
        currentPosition: tile.currentPosition,
      );
    }

    return Puzzle(tiles: tiles);
  }

  /// Sorts puzzle tiles so they are in order of their current position.
  Puzzle sort() {
    final sortedTiles = tiles.toList()
      ..sort(
        (firstTile, secondTile) =>
            firstTile.currentPosition.compareTo(secondTile.currentPosition),
      );
    return Puzzle(tiles: sortedTiles);
  }

  @override
  List<Object> get props => [tiles];
}
