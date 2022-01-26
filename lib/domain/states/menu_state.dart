import 'package:mobx/mobx.dart';

part 'menu_state.g.dart';

class MenuState = _MenuState with _$MenuState;

abstract class _MenuState with Store {
  ///Bools for checking if buttons are pressed
  @observable
  bool continueBtnPressed = false;

  @observable
  bool newGameBtnPressed = false;

  @observable
  bool exitBtnPressed = false;

  ///Bools for checking if buttons are hovered
  @observable
  bool continueBtnHovered = false;

  @observable
  bool newGameBtnHovered = false;

  @observable
  bool exitBtnHovered = false;

  ///Changes buttons' current state in the case of pressing

  @action
  void togglePressedBtn(int btnIndex) {
    switch (btnIndex) {
      case 0:
        continueBtnPressed = !continueBtnPressed;
        break;
      case 1:
        newGameBtnPressed = !newGameBtnPressed;
        break;
      case 2:
        exitBtnPressed = !exitBtnPressed;
        break;
      default:
        print('Unknown button pressed');
    }
  }

  ///Changes buttons' current state in the case of hovering
  @action
  void toggleHoveredBtn(int btnIndex) {
    switch (btnIndex) {
      case 0:
        continueBtnHovered = !continueBtnHovered;
        break;
      case 1:
        newGameBtnHovered = !newGameBtnHovered;
        break;
      case 2:
        exitBtnHovered = !exitBtnHovered;
        break;
      default:
        print('Unknown button hovered');
    }
  }
}
