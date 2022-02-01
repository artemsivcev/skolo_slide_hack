import 'package:cropperx/cropperx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/new_game_state.dart';

import '../polymorphic_container.dart';
import '../text_shadows.dart';

class ImageChooser extends StatefulWidget {
  const ImageChooser({Key? key}) : super(key: key);

  @override
  _ImageChooserState createState() => _ImageChooserState();
}

class _ImageChooserState extends State<ImageChooser> {
  final newGameState = injector<NewGameState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Choose Image',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 24,
              shadows: TextShadows.generateLongShadow(),
              fontWeight: FontWeight.w900,
              color: colorsPurpleBluePrimary,
            ),
          ),
        ),
        Observer(builder: (context) {
          var showChosen = newGameState.chosenImage != null;
          var showCropped = newGameState.croppedImage != null;
          var showPreview = !showChosen && !showCropped;
          return InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async => {
              await newGameState.chooseImagePress(),
              newGameState.isBtnChooseImagePressed = false,
            },
            child: AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(showCropped ? 16.0 : 8.0),
                border: Border.all(color: colorsGreyMediumPrimary, width: 1.5),
              ),
              duration: const Duration(seconds: 2),
              child: PolymorphicContainer(
                userInnerStyle: true,
                externalBorderRadius: showCropped ? 15.0 : 7.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(showCropped ? 16.0 : 8.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (showPreview)
                          SvgPicture.asset(
                            'assets/images/puzzle-continue.svg',
                            color: colorsPurpleBluePrimary,
                            height: newGameState.getImageMaxSize(context),
                          )
                        else
                          const SizedBox(),
                        AnimatedContainer(
                          width: newGameState.getAnimatedContainerSize(context),
                          height:
                              newGameState.getAnimatedContainerSize(context),
                          duration: const Duration(seconds: 2),
                          curve: Curves.fastOutSlowIn,
                          child: showCropped
                              ? Image.memory(
                                  newGameState.croppedImage!.buffer
                                      .asUint8List(),
                                  fit: BoxFit.scaleDown,
                                )
                              : showChosen
                                  ? Cropper(
                                      backgroundColor: Colors.white,
                                      cropperKey: newGameState.cropperKey,
                                      overlayType: OverlayType.rectangle,
                                      image: Image.memory(
                                          newGameState.chosenImage!),
                                    )
                                  : const SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
