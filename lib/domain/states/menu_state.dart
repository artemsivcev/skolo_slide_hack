import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/choose_image_state.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';
import 'package:skolo_slide_hack/domain/states/sound_state.dart';

part 'menu_state.g.dart';

class MenuState = _MenuState with _$MenuState;

/// State is used for manipulating with main settings of the game.
/// For example, when the user wants to go back or choosing
/// to play the game with image or not.
abstract class _MenuState with Store {
  /// state for sound manipulating
  final soundState = injector<SoundState>();
  @observable
  bool isShowImagePicker = false;

  @observable
  bool isShowGame = false;

  /// restore all bools and go back to menu
  /// todo mb add dispose?
  @action
  Future<void> backToMenu() async {
    isShowImagePicker = false;
    isShowGame = false;
    soundState.playBackwardSound();
    injector<ChooseImageState>().resetChooseImageStateData();
    injector<PuzzleState>().resetTimer();
    injector<PuzzleState>().resetMovementsCounter();
  }

  /// logic for play btn. It changes btn state
  /// and calls [splitImage] function
  @action
  Future<void> playWithImagePress() async {
    isShowImagePicker = true;
    soundState.playForwardSound();
  }

  /// crops the image and starts the game
  @action
  Future<void> cropImageAndPlay() async {
    isShowImagePicker = true;
    // soundState.playForwardSound();
    // //todo crop image and call play
    // // if (croppedImage != null) imageMap = splitImage();
    // //need to generate new puzzle with image/not
    // injector<PuzzleState>().generatePuzzle();
    playGame();
  }

  /// logic for play btn without image
  @action
  Future<void> playWithOutImagePress() async {
    soundState.playForwardSound();
    playGame();
  }

  /// starts the game
  @action
  Future<void> playGame() async {
    isShowGame = true;
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
