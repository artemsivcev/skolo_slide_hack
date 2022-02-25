import 'dart:async';
import 'dart:math';

import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/enums/corners_enum.dart';
import 'package:skolo_slide_hack/domain/models/position.dart';
import 'package:skolo_slide_hack/domain/models/puzzle.dart';
import 'package:skolo_slide_hack/domain/models/tile.dart';
import 'package:skolo_slide_hack/domain/states/sound_state.dart';
import 'package:skolo_slide_hack/domain/states/tile_animation_state.dart';
import 'package:skolo_slide_hack/domain/states/win_animation_state.dart';

import 'choose_image_state.dart';
import 'difficulty_state.dart';

part 'puzzle_state.g.dart';

class PuzzleState = _PuzzleState with _$PuzzleState;

/// State is used for manipulating with puzzles and their main features.
abstract class _PuzzleState with Store {
  /// need to access to sounds
  final soundState = injector<SoundState>();

  /// for animating tiles
  final TileAnimationState tileAnimationState = injector<TileAnimationState>();

  ///state with win animation
  final winAnimationState = injector<WinAnimationState>();

  ///state with board size
  final difficultyState = injector<DifficultyState>();

  ///state with user image data
  final chooseImageState = injector<ChooseImageState>();

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

  /// counter shows how many moves a user makes to solve puzzle.
  @observable
  int movementsCounter = 0;

  /// game start time
  @observable
  DateTime? gameStartTime;

  /// observable for checking time at the moment
  @observable
  ObservableStream<DateTime> _time = Stream.periodic(Duration(seconds: 1))
      .map((_) => DateTime.now())
      .asObservable();

  late StreamSubscription _gameTimerSubscription;

  @observable
  DateTime? now;

  /// timer for the game
  @computed
  Duration get gameTimer => gameStartTime != null && now != null
      ? now!.difference(gameStartTime!)
      : const Duration(minutes: 0, seconds: 0);

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
        difficultyState.boardSize,
        (difficultyState.boardSize * difficultyState.boardSize) -
            difficultyState.boardSize +
            1,
        difficultyState.boardSize * difficultyState.boardSize,
      ];

  /// if the user win the game
  @computed
  bool get isComplete => puzzle == null ? false : puzzle!.isComplete;

  ///minutes for the timer
  @computed
  String get minutes =>
      gameTimer.inMinutes.remainder(60).toString().padLeft(2, "0");

  ///seconds for the timer
  @computed
  String get seconds =>
      gameTimer.inSeconds.remainder(60).toString().padLeft(2, "0");

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

      if (movementsCounter == 0) {
        gameStartTime = DateTime.now();
        now = DateTime.now();
        _gameTimerSubscription = _time.listen((value) {
          now = value;
        });
      }
      movementsCounter += Puzzle.movementsCount;

      puzzle = puzzleWithMovedTiles.sort();
    }

    if (isComplete) {
      tileAnimationState.currentAnimationPhase = TileAnimationPhase.WIN;
      winAnimationState.animate();
      setFinalTime();
      soundState.playWinSound();
    }
  }

  /// Build puzzle of the given size.
  @action
  void generatePuzzle() {
    final correctPositions = <Position>[];
    final currentPositions = <Position>[];
    final emptyPos =
        Position(x: difficultyState.boardSize, y: difficultyState.boardSize);

    // Create all possible board positions.
    for (var y = 1; y <= difficultyState.boardSize; y++) {
      for (var x = 1; x <= difficultyState.boardSize; x++) {
        final pos = Position(x: x, y: y);
        correctPositions.add(
            x == difficultyState.boardSize && y == difficultyState.boardSize
                ? emptyPos
                : pos);
        currentPositions.add(
            x == difficultyState.boardSize && y == difficultyState.boardSize
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
        Position(x: difficultyState.boardSize, y: difficultyState.boardSize);

    return List.generate(
      difficultyState.boardSize * difficultyState.boardSize,
      (index) => Tile(
        value: index + 1,
        correctPosition:
            index + 1 == difficultyState.boardSize * difficultyState.boardSize
                ? emptyPosition
                : correctPositions[index],
        currentPosition: currentPositions[index],
        isEmpty:
            index + 1 == difficultyState.boardSize * difficultyState.boardSize,
        customImage: chooseImageState.imageMap != null
            ? chooseImageState.imageMap![index]
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
    resetMovementsCounter();
    resetTimer();
    toggleShuffleBtn();
    if (isComplete) {
      winAnimationState.animate();
    }
    generatePuzzle();
    toggleShuffleBtn();
  }

  /// change press for buttons
  @action
  void toggleShuffleBtn() => shuffleBtnPressed = !shuffleBtnPressed;

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

  /// resets amount of the moves to 0
  @action
  void resetMovementsCounter() {
    Puzzle.movementsCount = 0;
    movementsCounter = 0;
  }

  /// resets timer to 0
  @action
  void resetTimer() {
    gameStartTime = null;
    _time = Stream.periodic(Duration(seconds: 1))
        .map((_) => DateTime.now())
        .asObservable();
  }

  ///sets final time result of the game
  @action
  void setFinalTime() {
    _gameTimerSubscription.cancel();
  }
}
