import 'package:mobx/mobx.dart';

part 'buttons_hover_state.g.dart';

class ButtonsHoverState = _ButtonsHoverState with _$ButtonsHoverState;

abstract class _ButtonsHoverState with Store {
  ///Bools for checking if buttons are hovered

  @observable
  bool exitBtnHovered = false;

  @observable
  bool isSoundHovered = false;

  /// bools for difficulty levels hover
  @observable
  bool isEasyLevelHovered = false;
  @observable
  bool isMiddleLevelHovered = false;
  @observable
  bool isHardLevelHovered = false;

  /// bool for play hover
  @observable
  bool isPlayWithImageHovered = false;

  /// bool for play hover
  @observable
  bool isPlayHovered = false;

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

  /// easy level btn hover change
  @action
  void toggleHoveredEasyLevel() {
    isEasyLevelHovered = !isEasyLevelHovered;
  }

  /// easy level btn hover change
  @action
  void toggleHoveredMiddleLevel() {
    isMiddleLevelHovered = !isMiddleLevelHovered;
  }

  /// easy level btn hover change
  @action
  void toggleHoveredHardLevel() {
    isHardLevelHovered = !isHardLevelHovered;
  }

  /// fun for play btn hover change
  @action
  void toggleHoveredPlay() {
    isPlayHovered = !isPlayHovered;
  }

  /// bool for crop hover
  @observable
  bool isBackHover = false;

  /// fun for crop btn hover change
  @action
  void toggleBackHover() {
    isBackHover = !isBackHover;
  }

  /// bool for crop hover
  @observable
  bool isCropHovered = false;

  /// fun for crop btn hover change
  @action
  void toggleHoveredCrop() {
    isCropHovered = !isCropHovered;
  }

  @observable
  bool shuffleBtnHovered = false;



  /// change hover for buttons
  @action
  void toggleHoveredShuffleBtn() => shuffleBtnHovered = !shuffleBtnHovered;
}
