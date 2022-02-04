import 'dart:math';

import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/enums/corners_enum.dart';
import 'package:skolo_slide_hack/domain/models/position.dart';
import 'package:skolo_slide_hack/domain/models/puzzle.dart';
import 'package:skolo_slide_hack/domain/models/tile.dart';
import 'package:skolo_slide_hack/domain/states/sound_state.dart';
import 'package:skolo_slide_hack/domain/states/start_animation_state.dart';
import 'package:skolo_slide_hack/domain/states/win_animation_state.dart';

import 'new_game_state.dart';

part 'puzzle_state.g.dart';

class PuzzleState = _PuzzleState with _$PuzzleState;

abstract class _PuzzleState with Store {
  /// need to access to sounds
  final soundState = injector<SoundState>();
  final winAnimationState = injector<WinAnimationState>();
  final _startAnimationState = injector<StartAnimationState>();

  //state with user image data
  final newGameState = injector<NewGameState>();

  /// [random] is used for randomly shuffling puzzle
  /// as the main purpose of this game
  final Random random = Random();

  /// main puzzle board with tiles and main methods
  @observable
  Puzzle? puzzle;

  /// additional, auxiliary puzzle with tiles in correct order.
  /// used for animation purposes and not for a game.
  @observable
  Puzzle? correctPuzzle;

  /// buttons tap and hover states
  @observable
  bool shuffleBtnPressed = false;
  @observable
  bool shuffleBtnHovered = false;

  /// list of tiles
  @computed
  List<Tile> get tiles => puzzle == null ? [] : puzzle!.tiles;

  @computed
  List<Tile> get correctTiles => puzzle == null ? [] : correctPuzzle!.tiles;

  /// list of values that corresponds to the tiles in corners.
  /// Depends on the puzzle boarder size.
  /// For example, if the puzzle dimension is 4x4, the tiles in
  /// cornets should have values 1, 4, 13 and 16
  ///  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐
  ///  │  1  │ │  2  │ │  3  │ │  4  │
  ///  └─────┘ └─────┘ └─────┘ └─────┘
  ///  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐
  ///  │  5  │ │  6  │ │  7  │ │  8  │
  ///  └─────┘ └─────┘ └─────┘ └─────┘
  ///  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐
  ///  │  9  │ │ 10  │ │ 11  │ │ 12  │
  ///  └─────┘ └─────┘ └─────┘ └─────┘
  ///  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐
  ///  │ 13  │ │ 14  │ │ 15  │ │ 16  │
  ///  └─────┘ └─────┘ └─────┘ └─────┘
  @computed
  List<int> get valuesCornerTiles => [
        1,
        newGameState.boardSize,
        (newGameState.boardSize * newGameState.boardSize) -
            newGameState.boardSize +
            1,
        newGameState.boardSize * newGameState.boardSize,
      ];

  /// if the user win the game
  @computed
  bool get isComplete => puzzle == null ? false : puzzle!.isComplete;

  /// [onTileTapped] stands for method that is invoked when any tile is tapped.
  /// Index of tapped tile need ti be passed.
  /// Check if tile is movable and modifies puzzle board.
  @action
  void onTileTapped(int indexTappedTile) {
    final tappedTile = tiles[indexTappedTile];

    if (puzzle!.isTileMovable(tappedTile) && !isComplete) {
      soundState.playMoveSound();
      final mutablePuzzle = Puzzle(tiles: tiles);
      final puzzleWithMovedTiles = mutablePuzzle.moveTiles(tappedTile, []);
      puzzle = puzzleWithMovedTiles.sort();
    } else {
      soundState.playCantMoveSound();
    }

    if (isComplete) {
      winAnimationState.animate();
      soundState.playWinSound();
    }
  }

  /// Build puzzle of the given size.
  @action
  void generatePuzzle() {
    final correctPositions = <Position>[];
    final currentPositions = <Position>[];
    final emptyPos =
        Position(x: newGameState.boardSize, y: newGameState.boardSize);

    // Create all possible board positions.
    for (var y = 1; y <= newGameState.boardSize; y++) {
      for (var x = 1; x <= newGameState.boardSize; x++) {
        final pos = Position(x: x, y: y);
        correctPositions.add(
            x == newGameState.boardSize && y == newGameState.boardSize
                ? emptyPos
                : pos);
        currentPositions.add(
            x == newGameState.boardSize && y == newGameState.boardSize
                ? emptyPos
                : pos);
      }
    }

    correctPuzzle = Puzzle(
      tiles: getTilesFromPositions(
        correctPositions: correctPositions,
        currentPositions: currentPositions,
      ),
    );

    // shuffle puzzle
    puzzle = shufflePuzzle(
      correctPos: correctPositions,
      currentPos: currentPositions,
    );
  }

  /// Build a list of tiles with their correct and current position.
  List<Tile> getTilesFromPositions({
    required List<Position> correctPositions,
    required List<Position> currentPositions,
  }) {
    final emptyPosition =
        Position(x: newGameState.boardSize, y: newGameState.boardSize);

    return List.generate(
      newGameState.boardSize * newGameState.boardSize,
      (index) => Tile(
        value: index + 1,
        correctPosition:
            index + 1 == newGameState.boardSize * newGameState.boardSize
                ? emptyPosition
                : correctPositions[index],
        currentPosition: currentPositions[index],
        isEmpty: index + 1 == newGameState.boardSize * newGameState.boardSize,
        customImage: newGameState.imageMap != null
            ? newGameState.imageMap![index]
            : null,
        corner: setCorner(
          valuesCornerTiles.indexOf(index + 1),
        ),
      ),
    );
  }

  /// on shuffle button tap
  @action
  Future<void> shuffleButtonTap() async {
    toggleShuffleBtn();
    if (isComplete) winAnimationState.animate();
    soundState.playShuffleSound();
    generatePuzzle();

    /// todo make depending on animation
    await Future.delayed(const Duration(milliseconds: 450));
    toggleShuffleBtn();
  }

  /// change press for buttons
  @action
  void toggleShuffleBtn() => shuffleBtnPressed = !shuffleBtnPressed;

  /// change hover for buttons
  @action
  void toggleHoveredShuffleBtn() => shuffleBtnHovered = !shuffleBtnHovered;

  /// shuffle puzzle tiles with [random]
  Puzzle shufflePuzzle({
    required List<Position> correctPos,
    required List<Position> currentPos,
  }) {
    // Randomize the current tile positions.
    currentPos.shuffle(random);

    var newTiles = getTilesFromPositions(
      correctPositions: correctPos,
      currentPositions: currentPos,
    );

    var newPuzzle = Puzzle(tiles: newTiles);

    // Assign the tiles new current positions until the puzzle can be solved
    while (!newPuzzle.canBeSolved) {
      currentPos.shuffle(random);
      newTiles = getTilesFromPositions(
        correctPositions: correctPos,
        currentPositions: currentPos,
      );
      newPuzzle = Puzzle(tiles: newTiles);
    }
    return newPuzzle.sort();
  }
}
