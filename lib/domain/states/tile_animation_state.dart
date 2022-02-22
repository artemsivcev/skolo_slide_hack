import 'package:mobx/mobx.dart';

part 'tile_animation_state.g.dart';

class TileAnimationState = _TileAnimationState with _$TileAnimationState;

abstract class _TileAnimationState with Store {
  @observable
  TileAnimationPhase? currentAnimationPhase;
}

/// Enum for tiles' animation. Normal stands for normal game mode without any animation.
enum TileAnimationPhase {
  START_ANIMATION,
  WIN,
  SHUFFLE,
  NORMAL,
}
