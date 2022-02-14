import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/buttons_hover_state.dart';
import 'package:skolo_slide_hack/domain/states/choose_image_state.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';
import 'package:skolo_slide_hack/domain/states/sound_state.dart';

part 'menu_state.g.dart';

class MenuState = _MenuState with _$MenuState;

/// State is used for manipulating with main settings of the game.
/// For example, when the user wants to go back or choosing
/// to play the game with image or not.
abstract class _MenuState with Store {
  @observable
  GameState currentGameState = GameState.MAIN_MENU;

  @observable
  GameState? previousGameState;

  /// state for sound manipulating
  final soundState = injector<SoundState>();

  @action
  changeCurrentGameState(GameState state) {
    previousGameState = currentGameState;

    currentGameState = state;
  }

  /// restore all bools and go back to menu
  /// todo mb add dispose?
  @action
  Future<void> backToMenu() async {
    changeCurrentGameState(GameState.MAIN_MENU);
    soundState.playBackwardSound();
    injector<ChooseImageState>().resetChooseImageStateData();
    injector<ButtonsHoverState>().setAllHoveredToFalse();
  }

  /// logic for play btn. It changes btn state
  /// and calls [splitImage] function
  @action
  Future<void> playWithImagePress() async {
    changeCurrentGameState(GameState.CHOSE_IMAGE);
    soundState.playForwardSound();
  }

  /// logic for play btn without image
  @action
  Future<void> playWithOutImagePress() async {
    soundState.playForwardSound();
    changeCurrentGameState(GameState.WITHOUT_IMAGE_PLAY);
    injector<PuzzleState>().generatePuzzle();
  }

  @observable
  bool exitBtnPressed = false;

  /// press exit button (for mobile)
  @action
  void toggleExitBtn() {
    exitBtnPressed = !exitBtnPressed;
    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }
  }
}

enum GameState {
  MAIN_MENU,
  CHOSE_IMAGE,
  WITHOUT_IMAGE_PLAY,
  DEFAULT_IMAGE_PLAY,
  CUSTOM_IMAGE_PLAY,
  SHUFFLE,
  WIN,
  EXIT_GAME,
}
