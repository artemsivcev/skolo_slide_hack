import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/domain/constants/timers.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/models/position.dart';
import 'package:skolo_slide_hack/domain/models/puzzle.dart';
import 'package:skolo_slide_hack/domain/models/tile.dart';

import 'new_game_state.dart';

part 'puzzle_state.g.dart';

class PuzzleState = _PuzzleState with _$PuzzleState;

abstract class _PuzzleState with Store {
  /// Animation controller for start animation
  /// when user come to the screen at the first time.
  AnimationController? startAnimationController;

  /// size of board (if dimensions are 4x4, size is 4)
  final int size = 4;
  //state with user image data
  final newGameState = injector<NewGameState>();

  /// [random] is used for randomly shuffling puzzle
  /// as the main purpose of this game
  final Random random = Random();

  /// main puzzle board with tiles and main methods
  @observable
  Puzzle? puzzle;

  /// list of tiles
  @computed
  List<Tile> get tiles => puzzle == null ? [] : puzzle!.tiles;

  /// if the user win the game
  @computed
  bool get isComplete => puzzle == null
      ? false
      : isFirstScreenEntry
          ? false
          : puzzle!.isComplete;


  /// list of [tiles] correct positions
  @computed
  List<Position> get tilesCorrectPositions =>
      tiles.map((e) => e.correctPosition).toList();

  /// User enter to the screen at the first time.
  @observable
  bool isFirstScreenEntry = true;

  _PuzzleState() {
    generatePuzzle();
  }

  /// [onTileTapped] stands for method that is invoked when any tile is tapped.
  /// Index of tapped tile need ti be passed.
  /// Check if tile is movable and modifies puzzle board.
  @action
  void onTileTapped(int indexTappedTile) {
    final tappedTile = tiles[indexTappedTile];

    if (puzzle!.isTileMovable(tappedTile) && !isComplete) {
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

    puzzle = Puzzle(
        tiles: getTilesFromPositions(
      correctPositions: correctPositions,
      currentPositions: currentPositions,
    ));

    // // shuffle puzzle
    // puzzle = shufflePuzzle(
    //   correctPos: correctPositions,
    //   currentPos: currentPositions,
    // );
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
      ),
    );
  }

  /// on shuffle button tap
  @action
  void shuffleButtonTap() => generatePuzzle();

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

  //todo replace ALL !!! that below to separate class

  late double borderOneTileDuration;
  late double borderValue;

  late double blowOneTileDuration;
  late double blowValue;

  initStartAnimationController(TickerProvider tickerProvider) {
    print('init Start animation Controller');
    startAnimationController = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(
        milliseconds: startAnimationCommonDuration,
      ),
    );

    borderOneTileDuration = startBorderCornerAnimationDuration / tiles.length;
    borderValue = borderOneTileDuration / startAnimationCommonDuration;

    blowOneTileDuration = startBlowAnimationDuration / tiles.length;
    blowValue = blowOneTileDuration / startAnimationCommonDuration;
    //
    // print('tiles length: ${tiles.length}');
    // print('borderOneTileDuration: $borderOneTileDuration, value: $borderValue');
    // print('blowOneTileDuration: $blowOneTileDuration, value: $blowValue');
  }

  double borderStartAnimatingBeginValue(int tileIndex) {
    var result = 0.0;

    result =
        (borderOneTileDuration / startAnimationCommonDuration) * (tileIndex);

    return result;
  }

  double borderStartAnimatingEndValue(int tileIndex) {
    var result = 0.0;

    result = borderValue * (tileIndex + 1);

    return result;
  }

  double blowStartAnimationBeginValue(int tileIndex) {
    var result = 0.0;

    result =
        (borderOneTileDuration / startAnimationCommonDuration) * (tileIndex);

    return result;
  }

  double blowStartAnimationEndValue(int tileIndex) {
    var result = 0.0;

    result = borderValue * (tileIndex + 1);

    return result;
  }

  void dispose() {
    startAnimationController?.dispose();
  }
}
