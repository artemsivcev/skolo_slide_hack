import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:skolo_slide_hack/domain/models/tile.dart';

/// Model for a puzzle.
class Puzzle extends Equatable {
  const Puzzle({required this.tiles});

  /// List of [Tile]s representing the puzzle's current arrangement.
  final List<Tile> tiles;

  /// Get the empty tile object in the puzzle.
  Tile get getEmptyTile => tiles.singleWhere((tile) => tile.isEmpty);

  /// The dimension of a puzzle due to its tile layout
  /// For example: A dimension of a 4x4 puzzle is 4.
  int get getDimension => sqrt(tiles.length).toInt();

  /// Determines if the tapped tile can move in the direction of the empty tile.
  bool isTileMovable(Tile tile) {
    final emptyTile = getEmptyTile;
    if (tile == emptyTile) {
      return false;
    }

    // A tile must be in the same row or column as the empty to move.
    if (emptyTile.currentPosition.x != tile.currentPosition.x &&
        emptyTile.currentPosition.y != tile.currentPosition.y) {
      return false;
    }
    return true;
  }

  /// Shifts one or many tiles and returns the modified puzzle.
  /// A list of all tiles that need to be moved is recursively stored and swapped by [swapTiles].
  Puzzle moveTiles(Tile tile, List<Tile> tilesToSwap) {
    final deltaX = getEmptyTile.currentPosition.deltaX(tile.currentPosition);
    final deltaY = getEmptyTile.currentPosition.deltaY(tile.currentPosition);

    // if tile is positioned near the empty tile, we just pass it for swapping each other.
    // if it is not, we recursively pass it to the same method and
    // swap in individual order after it finally stands near the empty one.
    if (deltaX.abs() + deltaY.abs() > 1) {
      // find the nearest position we need to shift the tile due to deltas
      final shiftX = tile.currentPosition.x + deltaX.sign;
      final shiftY = tile.currentPosition.y + deltaY.sign;
      final tileToSwapWith = tiles.singleWhere((tile) =>
          tile.currentPosition.x == shiftX && tile.currentPosition.y == shiftY);
      tilesToSwap.add(tile);
      return moveTiles(tileToSwapWith, tilesToSwap);
    } else {
      tilesToSwap.add(tile);
      return swapTiles(tilesToSwap);
    }
  }

  /// Returns puzzle with new tile arrangement after swapping each
  /// tile in [tilesToSwap] with the empty onr.
  Puzzle swapTiles(List<Tile> tilesToSwap) {
    for (var tileToSwap in tilesToSwap.reversed) {
      final tileIndex = tiles.indexOf(tileToSwap);
      final tile = tiles[tileIndex];
      final emptyTile = getEmptyTile;
      final emptyTileIndex = tiles.indexOf(emptyTile);

      // Swap current board positions of the moving tile and the empty.
      tiles[tileIndex] = tile.copyWith(
        currentPosition: emptyTile.currentPosition,
      );
      tiles[emptyTileIndex] = emptyTile.copyWith(
        currentPosition: tile.currentPosition,
      );
    }

    return Puzzle(tiles: tiles);
  }

  /// Sorts puzzle tiles so they are in order of their current position.
  Puzzle sort() {
    final sortedTiles = [...tiles]..sort(
        (firstTile, secondTile) =>
            firstTile.currentPosition.compareTo(secondTile.currentPosition),
      );
    return Puzzle(tiles: sortedTiles);
  }

  /// Detects if puzzle is solvable
  /// It depends on the number of inversion (an inversion is any pair of tiles that are not
  /// in the correct order) and should suits the formula:
  /// - If the puzzle width is odd, the number of inversions in a solvable situation is even.
  /// - If the puzzle width is even, and the blank is on an even row counting from the bottom,
  /// the number of inversions in a solvable situation is odd.
  /// - If the puzzle width is even, and the blank is on an odd row counting from the bottom,
  /// the number of inversions in a solvable situation is even.
  bool get canBeSolved {
    var puzzleDimension = getDimension;
    var inversions = countInversions();

    if (puzzleDimension.isOdd) {
      return inversions.isEven;
    }

    var emptyTileRow = getEmptyTile.currentPosition.y;

    return (puzzleDimension - emptyTileRow + 1).isEven
        ? inversions.isOdd
        : inversions.isEven;
  }

  /// Count the number of inversions in a puzzle due to the tile layout.
  /// Empty tile is not considered when finding inversions.
  int countInversions() {
    var count = 0;

    for (var i = 0; i < tiles.length; i++) {
      if (tiles[i].isEmpty) continue;

      for (var j = i + 1; j < tiles.length; j++) {
        if (!tiles[j].isEmpty && isInversion(tiles[i], tiles[j])) {
          count++;
        }
      }
    }
    return count;
  }

  /// Determines if there is an inversion between tiles. As tiles are not sorted due to their
  /// current position now (their values are placed correctly in the ascending order),
  /// we need to compare their current position - not values:
  /// A tile of a higher value should be in a greater position than a tile of a lower value.
  bool isInversion(Tile a, Tile b) =>
      a.currentPosition.compareTo(b.currentPosition) > 0;

  /// Count the number of tiles that are placed in their correct position.
  int get countCorrectTiles {
    final emptyTile = getEmptyTile;
    var countCorrectTiles = 0;
    for (final tile in tiles) {
      if (tile == emptyTile) continue;

      if (tile.currentPosition == tile.correctPosition) {
        countCorrectTiles++;
      }
    }
    return countCorrectTiles;
  }

  /// Determines if the puzzle is completed.
  bool get isComplete => tiles.length == countCorrectTiles + 1;

  @override
  List<Object> get props => [tiles];
}
