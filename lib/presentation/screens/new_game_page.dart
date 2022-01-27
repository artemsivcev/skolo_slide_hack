import 'package:cropperx/cropperx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/new_game_state.dart';
import 'package:skolo_slide_hack/presentation/screens/puzzle_page.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu_screen/menu_button_widget.dart';
import 'package:skolo_slide_hack/presentation/widgets/polymorphic_container.dart';

class NewGamePage extends StatefulWidget {
  const NewGamePage({Key? key}) : super(key: key);

  @override
  State<NewGamePage> createState() => _NewGamePageState();
}

class _NewGamePageState extends State<NewGamePage> {
  final newGameState = injector<NewGameState>();

  // Define a key
  final _cropperKey = GlobalKey(debugLabel: 'cropperKey');

  Future<void> _cropImage() async {
    // Get the cropped image as bytes
    final imageBytes = await Cropper.crop(
      cropperKey: _cropperKey, // Reference it through the key
    );
    newGameState.chosenImage = null;
    newGameState.croppedImage = imageBytes;
  }

  @override
  Widget build(BuildContext buildContext) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Observer(builder: (context) {
        var showChosen = newGameState.chosenImage != null;
        var showCropped = newGameState.croppedImage != null;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuButtonWidget(
              iconUrl: 'assets/images/puzzle-continue.svg',
              btnText: 'Choose image',
              isPressed: newGameState.isBtnChooseImagePressed,
              onTap: () async {
                await newGameState.chooseImagePress();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 42.0),
              child: PolymorphicContainer(
                userInnerStyle: true,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        width: showChosen
                            ? width * 0.25
                            : showCropped
                                ? width * 0.35
                                : 225,
                        height: showChosen
                            ? width * 0.25
                            : showCropped
                                ? width * 0.35
                                : 225,
                        duration: const Duration(seconds: 2),
                        curve: Curves.fastOutSlowIn,
                        child: showCropped
                            ? Image.memory(
                                newGameState.croppedImage!.buffer.asUint8List(),
                                width: 225,
                                height: 225,
                                fit: BoxFit.scaleDown,
                              )
                            : showChosen
                                ? Cropper(
                                    backgroundColor: Colors.white,
                                    cropperKey: _cropperKey,
                                    overlayType: OverlayType.rectangle,
                                    image:
                                        Image.memory(newGameState.chosenImage!),
                                  )
                                : SvgPicture.asset(
                                    'assets/images/puzzle-new-filled.svg',
                                    color: colorsPurpleBluePrimary,
                                    width: 225,
                                    height: 225,
                                  ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 42.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 900),
                      child: showChosen
                          ? MenuButtonWidget(
                              iconUrl: 'assets/images/puzzle-new.svg',
                              btnText: 'Crop!',
                              isPressed: newGameState.isBtnPlayPressed,
                              onTap: () async {
                                await _cropImage();
                              },
                            )
                          : Container(),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 900),
                      child: showChosen
                          ? Container()
                          : MenuButtonWidget(
                              iconUrl: 'assets/images/puzzle-new.svg',
                              btnText: 'Play!',
                              isPressed: newGameState.isBtnPlayPressed,
                              onTap: () async {
                                await newGameState.playPress();
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        const PuzzlePage(),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
