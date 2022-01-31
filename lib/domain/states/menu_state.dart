import 'package:flutter/cupertino.dart';
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

  //fun's to toggle btn's
  @action
  void toggleContinueBtn() {
    continueBtnPressed = !continueBtnPressed;
  }

  @action
  void toggleNewFameBtn() {
    newGameBtnPressed = !newGameBtnPressed;
  }

  @action
  void toggleExitBtn() {
    exitBtnPressed = !exitBtnPressed;
  }

  //function help's to understand current user orientation by screen aspect ratio
  bool isPortrait(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return height > width;
  }
}
