import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'new_game_state.g.dart';

class NewGameState = _NewGameState with _$NewGameState;

abstract class _NewGameState with Store {
  //bool for btn state
  @observable
  bool isBtnChooseImagePressed = false;

  @observable
  Uint8List? croppedImage;

  final ImagePicker _picker = ImagePicker();

  Future<Uint8List?> chooseImagePress() async {
    isBtnChooseImagePressed = !isBtnChooseImagePressed;
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, maxWidth: 720);

    if (image != null) {
      return image.readAsBytes();
    } else {
      // User canceled the picker
    }
  }
}
