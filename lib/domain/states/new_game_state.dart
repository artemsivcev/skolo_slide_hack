import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'new_game_state.g.dart';

class NewGameState = _NewGameState with _$NewGameState;

abstract class _NewGameState with Store {
  //bool for btn state
  @observable
  bool isBtnChooseImagePressed = false;

  //bool for btn state
  @observable
  bool isBtnPlayPressed = false;

  //cropped image to preview on new game screen
  @observable
  Uint8List? chosenImage;

  //cropped image to preview on new game screen
  @observable
  Uint8List? croppedImage;

  // divided user image. first value in index and second is image in Unit8List format
  HashMap<dynamic, dynamic>? imageMap;

  // image picker controller to get image from user space
  final ImagePicker _picker = ImagePicker();

  /// size of board (if dimensions are 4x4, size is 4)
  final int boardSize = 4;

  // logic for choose image btn. It change btn state, choose image and return it
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

  // logic for play btn. It change btn state
  // and called [splitImage] function
  @action
  Future<void> playPress() async {
    isBtnPlayPressed = !isBtnPlayPressed;
    if (croppedImage != null) imageMap = splitImage();
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

  double getAnimatedContainerSize(BuildContext context){

    var showChosen = chosenImage != null;
    var showCropped = croppedImage != null;


    var size = showChosen
        ? getImageMaxSize(context)
        : showCropped
        ? getImageMaxSize(context,
        customMultiple: 0.5)
        : getImageMaxSize(context);

    return size;

  }
}
