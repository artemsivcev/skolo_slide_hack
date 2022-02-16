import 'package:mobx/mobx.dart';

part 'tile_animation_state.g.dart';

class TileAnimationState = _TileAnimationState with _$TileAnimationState;

abstract class _TileAnimationState with Store {
  @observable
  TileAnimationPhase? currentAnimationPhase;
}

enum TileAnimationPhase {
  START_ANIMATION,
  WIN,

  /// Without any animation. Normal game made.
  NORMAL,
  SHAFFLE,
  // add exit?
}
