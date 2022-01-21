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

  ///Changes buttons' current state
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
}
