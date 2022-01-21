// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'puzzle_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PuzzleState on _PuzzleState, Store {
  Computed<List<Tile>>? _$tilesComputed;

  @override
  List<Tile> get tiles => (_$tilesComputed ??=
          Computed<List<Tile>>(() => super.tiles, name: '_PuzzleState.tiles'))
      .value;
  Computed<List<Position>>? _$tilesCurrentPositionsComputed;

  @override
  List<Position> get tilesCurrentPositions =>
      (_$tilesCurrentPositionsComputed ??= Computed<List<Position>>(
              () => super.tilesCurrentPositions,
              name: '_PuzzleState.tilesCurrentPositions'))
          .value;
  Computed<List<Position>>? _$tilesCorrectPositionsComputed;

  @override
  List<Position> get tilesCorrectPositions =>
      (_$tilesCorrectPositionsComputed ??= Computed<List<Position>>(
              () => super.tilesCorrectPositions,
              name: '_PuzzleState.tilesCorrectPositions'))
          .value;

  final _$puzzleAtom = Atom(name: '_PuzzleState.puzzle');

  @override
  Puzzle? get puzzle {
    _$puzzleAtom.reportRead();
    return super.puzzle;
  }

  @override
  set puzzle(Puzzle? value) {
    _$puzzleAtom.reportWrite(value, super.puzzle, () {
      super.puzzle = value;
    });
  }

  final _$_PuzzleStateActionController = ActionController(name: '_PuzzleState');

  @override
  void onTileTapped(int indexTappedTile) {
    final _$actionInfo = _$_PuzzleStateActionController.startAction(
        name: '_PuzzleState.onTileTapped');
    try {
      return super.onTileTapped(indexTappedTile);
    } finally {
      _$_PuzzleStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void generatePuzzle() {
    final _$actionInfo = _$_PuzzleStateActionController.startAction(
        name: '_PuzzleState.generatePuzzle');
    try {
      return super.generatePuzzle();
    } finally {
      _$_PuzzleStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void shuffleButtonTap() {
    final _$actionInfo = _$_PuzzleStateActionController.startAction(
        name: '_PuzzleState.shuffleButtonTap');
    try {
      return super.shuffleButtonTap();
    } finally {
      _$_PuzzleStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
puzzle: ${puzzle},
tiles: ${tiles},
tilesCurrentPositions: ${tilesCurrentPositions},
tilesCorrectPositions: ${tilesCorrectPositions}
    ''';
  }
}
