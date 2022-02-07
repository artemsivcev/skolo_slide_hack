import 'dart:collection';
import 'dart:typed_data';

import 'package:cropperx/cropperx.dart';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';

import 'sound_state.dart';
part 'new_game_state.g.dart';

class NewGameState = _NewGameState with _$NewGameState;

abstract class _NewGameState with Store {
  /// need to access to sounds
  final soundState = injector<SoundState>();

  /// bool for choose image btn state
  @observable
  bool isBtnChooseImagePressed = false;

  /// bool for crop image btn state
  @observable
  bool isCropPressed = false;

  /// bool for play btn state
  @observable
  bool isPlayPressed = false;

  /// bool for crop hover
  @observable
  bool isCropHovered = false;

  /// fun for crop btn hover change
  @action
  void toggleHoveredCrop() {
    isCropHovered = !isCropHovered;
  }

  /// bool for play hover
  @observable
  bool isPlayHovered = false;

  /// fun for play btn hover change
  @action
  void toggleHoveredPlay() {
    isPlayHovered = !isPlayHovered;
  }

  /// cropped image to preview on new game screen
  @observable
  Uint8List? chosenImage;

  /// cropped image to preview on new game screen
  @observable
  Uint8List? croppedImage;

  /// divided user image. first value in index and second is image in Unit8List format
  @observable
  HashMap<dynamic, dynamic>? imageMap;

  /// image picker controller to get image from user space
  final ImagePicker _picker = ImagePicker();

  /// size of board (if dimensions are 4x4, size is 4)
  final int boardSize = 4;

  @observable
  bool isGameStart = false;

  /// logic for choose image btn. It changes btn state, chooses image and returns it
  @action
  Future<void> chooseImagePress() async {
    isBtnChooseImagePressed = !isBtnChooseImagePressed;
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 720,
      imageQuality: 25,
    );

    if (image != null) {
      croppedImage = null;
      chosenImage = await image.readAsBytes();
    } else {
      // User canceled the picker
    }
  }

  /// logic for play btn. It changes btn state
  /// and calls [splitImage] function
  @action
  Future<void> playPress() async {
    isGameStart = true;
    isPlayPressed = !isPlayPressed;
    soundState.playForwardSound();
    if (croppedImage != null) imageMap = splitImage();
    //need to generate new puzzle with image/not
    injector<PuzzleState>().generatePuzzle();
  }

  // logic for splitting image, working really bad, but we can use loaders!!!
  HashMap<dynamic, dynamic> splitImage() {
    print("start = " + DateTime.now().toString());

    //todo this is problem spot
    img.Image image = img.decodeImage(croppedImage!.toList())!;
    print("end decodeImage = " + DateTime.now().toString());
    int x = 0, y = 0;
    int width = (image.width / boardSize).floor();
    int height = (image.height / boardSize).floor();

    // split image to parts

    List<img.Image> parts = <img.Image>[];
    for (int i = 0; i < boardSize; i++) {
      for (int j = 0; j < boardSize; j++) {
        parts.add(img.copyCrop(image, x, y, width, height));
        x += width;
      }
      x = 0;
      y += height;
    }

    print("start fill map = " + DateTime.now().toString());
    HashMap output = HashMap<int, Uint8List>();
    for (int i = 0; i < parts.length; i++) {
      output.putIfAbsent(
          i, () => Uint8List.fromList(img.encodeJpg(parts[i], quality: 25)));
    }

    print("\nend = " + DateTime.now().toString());

    return output;
  }

  /// this function gets image max size due to screen width and height
  /// for adaptive layout
  double getImageMaxSize(BuildContext context, {double? customMultiple}) {
    double maxSize = 100.0;
    double multiple = 0.4;
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

  /// this function gets animated container size
  /// due to the state of image, selected by user
  double getAnimatedContainerSize(BuildContext context) {
    var showChosen = chosenImage != null;
    var showCropped = croppedImage != null;

    var size = showChosen
        ? getImageMaxSize(context)
        : showCropped
            ? getImageMaxSize(context, customMultiple: 0.5)
            : getImageMaxSize(context);

    return size;
  }

  // Define a key for cropper
  final cropperKey = GlobalKey(debugLabel: 'cropperKey');

  //function to crop chose image
  Future<void> cropImage() async {
    // Get the cropped image as bytes
    isCropPressed = !isCropPressed;
    final imageBytes = await Cropper.crop(
      cropperKey: cropperKey, // Reference it through the key
    );
    chosenImage = null;
    croppedImage = imageBytes;
  }

  //bool to show new game or first screen
  @observable
  bool isNewGameShow = false;
}
