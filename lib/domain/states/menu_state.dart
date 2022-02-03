import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/sound_state.dart';

part 'menu_state.g.dart';

class MenuState = _MenuState with _$MenuState;

abstract class _MenuState with Store {
  /// need to access to sounds
  final soundState = injector<SoundState>();

  ///Bools for checking if buttons are pressed
  @observable
  bool continueBtnPressed = false;

  @observable
  bool newGameBtnPressed = false;

  @observable
  bool exitBtnPressed = false;

  @observable
  bool isSoundPlay = false;

  ///Bools for checking if buttons are hovered
  @observable
  bool continueBtnHovered = false;

  @observable
  bool newGameBtnHovered = false;

  @observable
  bool exitBtnHovered = false;

  @observable
  bool isSoundHovered = false;

  ///Changes buttons' current state in the case of pressing
  @action
  void toggleContinueBtn() {
    continueBtnPressed = !continueBtnPressed;
  }

  @action
  void toggleNewGameBtn() {
    newGameBtnPressed = !newGameBtnPressed;
    soundState.playForwardSound();
  }

  @action
  void toggleExitBtn() {
    exitBtnPressed = !exitBtnPressed;
    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }
  }

  @action
  void toggleSoundBtn() {
    isSoundPlay = !isSoundPlay;

    soundState.toggleMainSound();
  }

  //change hover for buttons
  @action
  void toggleHoveredContinueBtn() {
    continueBtnHovered = !continueBtnHovered;
  }

  @action
  void toggleHoveredNewGameBtn() {
    newGameBtnHovered = !newGameBtnHovered;
  }

  @action
  void toggleHoveredExitBtn() {
    exitBtnHovered = !exitBtnHovered;
  }

  @action
  void toggleHoveredSound() {
    isSoundHovered = !isSoundHovered;
  }

  //function help's to understand current user orientation by screen aspect ratio
  bool isPortrait(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return height > width;
  }
}
