import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:mobx/mobx.dart';

part 'new_game_state.g.dart';

class NewGameState = _NewGameState with _$NewGameState;

abstract class _NewGameState with Store {
  //bool for btn state
  @observable
  bool isBtnChooseImagePressed = false;

  @observable
  Uint8List? croppedImage;

  Future<Uint8List?> chooseImagePress() async {
    isBtnChooseImagePressed = !isBtnChooseImagePressed;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result != null) {
      PlatformFile file = result.files.first;

      return file.bytes;
    } else {
      // User canceled the picker
    }
  }
}
