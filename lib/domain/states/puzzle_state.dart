import 'dart:math';
import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/domain/models/position.dart';
import 'package:skolo_slide_hack/domain/models/puzzle.dart';
import 'package:skolo_slide_hack/domain/models/tile.dart';

part 'puzzle_state.g.dart';

class PuzzleState = _PuzzleState with _$PuzzleState;

abstract class _PuzzleState with Store {
  /// size of board (if dimensions are 4x4, size is 4)
  final int size = 4;

  /// [random] is used for randomly shuffling puzzle
  /// as the main purpose of this game
  final Random random = Random();

  /// main puzzle board with tiles and main methods
  @observable
  Puzzle? puzzle;

  /// list of tiles
  @computed
  List<Tile> get tiles => puzzle == null ? [] : puzzle!.tiles;

  _PuzzleState() {
    generatePuzzle();
  }

  /// [onTileTapped] stands for method that is invoked when any tile is tapped.
  /// Index of tapped tile need ti be passed.
  /// Check if tile is movable and modifies puzzle board.
  @action
  void onTileTapped(int indexTappedTile) {
    final tappedTile = tiles[indexTappedTile];

    if (puzzle!.isTileMovable(tappedTile)) {
      final mutablePuzzle = Puzzle(tiles: tiles);
      final puzzleWithMovedTiles = mutablePuzzle.moveTiles(tappedTile, []);
      puzzle = puzzleWithMovedTiles.sort();
    }
  }

  /// Build puzzle of the given size.
  @action
  void generatePuzzle() {
    final correctPositions = <Position>[];
    final currentPositions = <Position>[];
    final emptyPos = Position(x: size, y: size);

    // Create all possible board positions.
    for (var y = 1; y <= size; y++) {
      for (var x = 1; x <= size; x++) {
        final pos = Position(x: x, y: y);
        correctPositions.add(x == size && y == size ? emptyPos : pos);
        currentPositions.add(x == size && y == size ? emptyPos : pos);
      }
    }

    // Randomize the current tile positions.
    currentPositions.shuffle(random);

    var tiles = getTilesFromPositions(
      correctPositions: correctPositions,
      currentPositions: currentPositions,
    );

    var newPuzzle = Puzzle(tiles: tiles);

    // Assign the tiles new current positions until the puzzle can be solved
    while (!newPuzzle.canBeSolved) {
      currentPositions.shuffle(random);
      tiles = getTilesFromPositions(
        correctPositions: correctPositions,
        currentPositions: currentPositions,
      );
      newPuzzle = Puzzle(tiles: tiles);
    }

    puzzle = newPuzzle.sort();
  }

  @action

  /// Build a list of tiles with their correct and current position.
  List<Tile> getTilesFromPositions({
    required List<Position> correctPositions,
    required List<Position> currentPositions,
  }) {
    final emptyPosition = Position(x: size, y: size);

    return List.generate(
      size * size,
      (index) => Tile(
        value: index + 1,
        correctPosition:
            index + 1 == size * size ? emptyPosition : correctPositions[index],
        currentPosition: currentPositions[index],
        isEmpty: index + 1 == size * size,
      ),
    );
  }
}
