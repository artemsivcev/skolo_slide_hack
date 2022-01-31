import 'package:cropperx/cropperx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/new_game_state.dart';
import 'package:skolo_slide_hack/presentation/screens/puzzle_page.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/background_with_bubbles.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/glass_container.dart';
import 'package:skolo_slide_hack/presentation/widgets/buttons/button_widget.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/row_column_solver.dart';
import 'package:skolo_slide_hack/presentation/widgets/polymorphic_container.dart';
import 'package:skolo_slide_hack/presentation/widgets/text_shadows.dart';

class NewGamePage extends StatefulWidget {
  const NewGamePage({Key? key}) : super(key: key);

  @override
  State<NewGamePage> createState() => _NewGamePageState();
}

class _NewGamePageState extends State<NewGamePage>
    with TickerProviderStateMixin {
  final newGameState = injector<NewGameState>();

  // Define a key
  final _cropperKey = GlobalKey(debugLabel: 'cropperKey');

  //crossfade state for buttons crop and play logic
  CrossFadeState _crossStateButtons = CrossFadeState.showFirst;

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
    var glassContainerWidth = width * 0.8;
    var defaultPreviewWidthHeight = width * 0.1;
    var imagePreviewWidthHeight = width * 0.2;
    var imageCroppedWidthHeight = width * 0.3;

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    if (width > 1024) {
      //more then 1024

      if (isPortrait) {
        glassContainerWidth = width * 0.32;
        defaultPreviewWidthHeight = width * 0.08;
        imagePreviewWidthHeight = width * 0.16;
        imageCroppedWidthHeight = width * 0.24;
      } else {
        glassContainerWidth = width * 0.72;
        defaultPreviewWidthHeight = width * 0.32;
        imagePreviewWidthHeight = width * 0.48;
        imageCroppedWidthHeight = width * 0.56;
      }
    } else if (width < 601) {
      //less then 601, mobile
      if (isPortrait) {
        glassContainerWidth = width * 0.72;
        defaultPreviewWidthHeight = width * 0.32;
        imagePreviewWidthHeight = width * 0.48;
        imageCroppedWidthHeight = width * 0.56;
      } else {
        glassContainerWidth = width * 0.72;
        defaultPreviewWidthHeight = width * 0.32;
        imagePreviewWidthHeight = width * 0.48;
        imageCroppedWidthHeight = width * 0.56;
      }
    } else {
      //600-1024
      if (isPortrait) {
        glassContainerWidth = width * 0.48;
        defaultPreviewWidthHeight = width * 0.24;
        imagePreviewWidthHeight = width * 0.32;
        imageCroppedWidthHeight = width * 0.40;
      } else {
        glassContainerWidth = width * 0.72;
        defaultPreviewWidthHeight = width * 0.32;
        imagePreviewWidthHeight = width * 0.48;
        imageCroppedWidthHeight = width * 0.56;
      }
    }

    return BackgroundWithBubbles(
      colorsBackground: colorsBackgroundMenu,
      child: Observer(builder: (context) {
        var showChosen = newGameState.chosenImage != null;
        var showCropped = newGameState.croppedImage != null;
        var showPreview = !showChosen && !showCropped;

        if (showChosen) {
          _crossStateButtons = CrossFadeState.showFirst;
        } else {
          _crossStateButtons = CrossFadeState.showSecond;
        }

        return GlassContainer(
          child: RowColumnSolver(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Choose Image',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: colorsGreyLightPrimary,
                      shadows: TextShadows.generateLongShadow(),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async => {
                      await newGameState.chooseImagePress(),
                      newGameState.isBtnChooseImagePressed = false,
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: colorsGreyMediumPrimary, width: 1.5),
                      ),
                      child: PolymorphicContainer(
                        userInnerStyle: true,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              if (showPreview)
                                SvgPicture.asset(
                                  'assets/images/puzzle-new-filled.svg',
                                  color: colorsPurpleBluePrimary,
                                  width: defaultPreviewWidthHeight,
                                  height: defaultPreviewWidthHeight,
                                )
                              else
                                SizedBox(
                                  width: defaultPreviewWidthHeight,
                                  height: defaultPreviewWidthHeight,
                                ),
                              AnimatedContainer(
                                width: showChosen
                                    ? imagePreviewWidthHeight
                                    : showCropped
                                        ? imageCroppedWidthHeight
                                        : defaultPreviewWidthHeight,
                                height: showChosen
                                    ? imagePreviewWidthHeight
                                    : showCropped
                                        ? imageCroppedWidthHeight
                                        : defaultPreviewWidthHeight,
                                duration: const Duration(seconds: 2),
                                curve: Curves.fastOutSlowIn,
                                child: showCropped
                                    ? Image.memory(
                                        newGameState.croppedImage!.buffer
                                            .asUint8List(),
                                        width: defaultPreviewWidthHeight,
                                        height: defaultPreviewWidthHeight,
                                        fit: BoxFit.scaleDown,
                                      )
                                    : showChosen
                                        ? Cropper(
                                            backgroundColor: Colors.white,
                                            cropperKey: _cropperKey,
                                            overlayType: OverlayType.rectangle,
                                            image: Image.memory(
                                                newGameState.chosenImage!),
                                          )
                                        : Container(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                AnimatedCrossFade(
                  crossFadeState: _crossStateButtons,
                  duration: const Duration(seconds: 2),
                  firstChild: ButtonWidget(
                    iconUrl: 'assets/images/puzzle-new.svg',
                    btnText: 'Crop!',
                    isPressed: false,
                    onTap: () async {
                      _cropImage();
                    },
                  ),
                  secondChild: ButtonWidget(
                    iconUrl: 'assets/images/puzzle-new-filled.svg',
                    btnText: 'Play!',
                    isPressed: false,
                    onTap: () async {
                      await newGameState.playPress();
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const PuzzlePage(),
                        ),
                      );
                    },
                  ),
                ),
              ]),
            ],
          ),
        );
      }),
    );
  }
}
