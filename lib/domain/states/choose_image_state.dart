import 'dart:collection';
import 'dart:typed_data';

import 'package:cropperx/cropperx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';
import 'package:skolo_slide_hack/domain/states/sound_state.dart';

import 'difficulty_state.dart';

part 'choose_image_state.g.dart';

class ChooseImageState = _ChooseImageState with _$ChooseImageState;

/// State is used for choosing image for playing puzzle game.
/// It is necessary for choosing, cropping, encoding and decoding images.
abstract class _ChooseImageState with Store {
  /// state with board size due to its difficulty
  final difficultyState = injector<DifficultyState>();
  final menuState = injector<MenuState>();
  final soundState = injector<SoundState>();

  /// cropped image to preview on new game screen
  @observable
  Uint8List? chosenImage;

  /// cropped image to preview on new game screen
  @observable
  int? chosenImageNumber;

  /// cropped image to preview on new game screen
  @observable
  Uint8List? croppedImage;

  /// divided user image. first value in index and second is image in Unit8List format
  @observable
  HashMap<dynamic, dynamic>? imageMap;

  ///chosen default image or not.
  ///null before choosing of an any kind of image.
  ///false if chosen a custom image.
  @observable
  bool chosenDefaultImage = false;

  ///chosen default image or not.
  ///null before choosing of an any kind of image.
  ///false if chosen a default image.
  @observable
  bool chosenCustomImage = false;

  /// image picker controller to get image from user space
  final ImagePicker _picker = ImagePicker();

  /// logic for choose image btn. It changes btn state, chooses image and returns it
  @action
  Future<void> chooseCustomImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 720,
      imageQuality: 25,
    );

    if (image != null) {
      chosenDefaultImage = false;
      chosenCustomImage = true;
      croppedImage = null;
      chosenImage = await image.readAsBytes();
    } else {
      // User canceled the picker
    }
    soundState.playChooseImageSound();
  }

  /// Define a key for cropper
  final cropperKey = GlobalKey(debugLabel: 'cropperKey');

  /// function to crop chose image
  @action
  Future<void> cropImage() async {
    // Get the cropped image as bytes
    // Reference it through the key
    final imageBytes = await Cropper.crop(cropperKey: cropperKey);
    chosenImage = null;
    croppedImage = imageBytes;
  }

  /// choosing default image if the user doesn't want to choose his own one.
  @action
  Future<void> chooseDefaultImage(String imageName, int imageNumber) async {
    chosenImageNumber = imageNumber;
    var data = (await rootBundle.load('assets/images/default/$imageName.png'))
        .buffer
        .asUint8List();
    chosenDefaultImage = true;
    chosenCustomImage = false;
    croppedImage = data;
    chosenImage = data;
    soundState.playChooseImageSound();
  }

  /// fun for split default image and start to play
  @action
  Future<void> splitImageAndPlay() async {
    await splitImage();
    injector<PuzzleState>().generatePuzzle();
    soundState.playForwardSound();
    menuState.changeCurrentGameState(chosenDefaultImage
        ? GameState.DEFAULT_IMAGE_PLAY
        : GameState.CUSTOM_IMAGE_PLAY);
  }

  /// logic for splitting image, working really bad, but we can use loaders!!!
  @action
  Future<void> splitImage() async {
    if (chosenCustomImage) {
      await cropImage();
    }

    //todo this is problem spot
    img.Image image = img.decodeImage(croppedImage!.toList())!;
    int x = 0, y = 0;
    int width = (image.width / difficultyState.boardSize).floor();
    int height = (image.height / difficultyState.boardSize).floor();

    // split image to parts

    List<img.Image> parts = <img.Image>[];
    for (int i = 0; i < difficultyState.boardSize; i++) {
      for (int j = 0; j < difficultyState.boardSize; j++) {
        parts.add(img.copyCrop(image, x, y, width, height));
        x += width;
      }
      x = 0;
      y += height;
    }

    HashMap output = HashMap<int, Uint8List>();
    for (int i = 0; i < parts.length; i++) {
      output.putIfAbsent(
          i, () => Uint8List.fromList(img.encodeJpg(parts[i], quality: 25)));
    }
    imageMap = output;
  }

  /// this function gets animated container size
  /// due to the state of image, selected by user
  double getAnimatedContainerSize(BuildContext context, bool showChosen) {
    var size = showChosen
        ? getImageMaxSize(context, customMultiple: 0.5)
        : getImageMaxSize(context);

    return size;
  }

  /// this function gets image max size due to screen width and height
  /// for adaptive layout
  double getImageMaxSize(BuildContext context, {double? customMultiple}) {
    double maxSize = 100.0;
    double multiple = 0.15;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    if (customMultiple != null) {
      multiple = customMultiple;
    }

    if (height > width) {
      maxSize = width * multiple;
    } else {
      maxSize = height * multiple;
    }

    return maxSize;
  }

  @action
  void resetChooseImageStateData() {
    chosenDefaultImage = false;
    chosenCustomImage = false;
    chosenImage = null;
    chosenImageNumber = null;
    croppedImage = null;
    imageMap = null;
    injector<PuzzleState>().generatePuzzle();
  }
}
