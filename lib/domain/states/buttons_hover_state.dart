import 'package:mobx/mobx.dart';

part 'buttons_hover_state.g.dart';

class ButtonsHoverState = _ButtonsHoverState with _$ButtonsHoverState;

/// State is used for detecting when buttons are hovered or not.
/// It is necessary for showing button border glow.
abstract class _ButtonsHoverState with Store {
  /// bools for buttons hover
  @observable
  bool exitBtnHovered = false;

  @observable
  bool isSoundHovered = false;

  @observable
  bool isEasyLevelHovered = false;

  @observable
  bool isMiddleLevelHovered = false;

  @observable
  bool isHardLevelHovered = false;

  @observable
  bool isPlayWithImageHovered = false;

  @observable
  bool isPlayHovered = false;

  @observable
  bool isBackHover = false;

  @observable
  bool isCropHovered = false;

  @observable
  bool shuffleBtnHovered = false;

  /// functions for changing button hover
  @action
  void toggleHoveredExitBtn() {
    exitBtnHovered = !exitBtnHovered;
  }

  @action
  void togglePlayWithImageHovered() {
    isPlayWithImageHovered = !isPlayWithImageHovered;
  }

  @action
  void toggleHoveredSound() {
    isSoundHovered = !isSoundHovered;
  }

  @action
  void toggleHoveredEasyLevel() {
    isEasyLevelHovered = !isEasyLevelHovered;
  }

  @action
  void toggleHoveredMiddleLevel() {
    isMiddleLevelHovered = !isMiddleLevelHovered;
  }

  @action
  void toggleHoveredHardLevel() {
    isHardLevelHovered = !isHardLevelHovered;
  }

  @action
  void toggleHoveredPlay() {
    isPlayHovered = !isPlayHovered;
  }

  @action
  void toggleBackHover() {
    isBackHover = !isBackHover;
  }

  @action
  void toggleHoveredCrop() {
    isCropHovered = !isCropHovered;
  }

  @action
  void toggleHoveredShuffleBtn() => shuffleBtnHovered = !shuffleBtnHovered;

  @action
  void setAllHoveredToFalse() {
    exitBtnHovered = false;
    isSoundHovered = false;
    isEasyLevelHovered = false;
    isMiddleLevelHovered = false;
    isHardLevelHovered = false;
    isPlayWithImageHovered = false;
    isPlayHovered = false;
    isBackHover = false;
    isCropHovered = false;
    shuffleBtnHovered = false;
  }
}
