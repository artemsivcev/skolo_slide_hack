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
  String toString() {
    return '''
puzzle: ${puzzle},
tiles: ${tiles}
    ''';
  }
}
