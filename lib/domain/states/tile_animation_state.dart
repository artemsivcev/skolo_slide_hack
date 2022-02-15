import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';

part 'tile_animation_state.g.dart';

class TileAnimationState = _TileAnimationState with _$TileAnimationState;

abstract class _TileAnimationState with Store {
  final MenuState _menuState = injector<MenuState>();

  @observable
  TileAnimationPhase? currentAnimationPhase;
}

enum TileAnimationPhase {
  START_ANIMATION,

  /// Without any animation. Normal game made.
  NORMAL,
  SHAFFLE,
  WIN,
  // add exit?
}
