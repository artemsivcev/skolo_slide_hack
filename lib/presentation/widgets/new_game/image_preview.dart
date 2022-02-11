import 'package:cropperx/cropperx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/domain/states/choose_image_state.dart';

class ImagePreview extends StatelessWidget {
  ImagePreview({Key? key}) : super(key: key);

  final chooseImageState = injector<ChooseImageState>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      var showChosen = chooseImageState.chosenImage != null;
      var showCropped = chooseImageState.croppedImage != null;
      var showPreview = !showChosen && !showCropped;
      var showOthers = chooseImageState.croppedImage == null;

      return showOthers
          ? InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                await chooseImageState.chooseCustomImage();
                // await Future.delayed(const Duration(seconds: 2));
                // chooseImageState.splitImageAndPlay();
              },
              child: Semantics(
                label: "Choose your own image",
                enabled: true,
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
                            height: chooseImageState.getImageMaxSize(context),
                          )
                        else
                          const SizedBox(),
                        AnimatedContainer(
                          width: chooseImageState.getAnimatedContainerSize(
                              context, showChosen),
                          height: chooseImageState.getAnimatedContainerSize(
                              context, showChosen),
                          duration: animationTwoSecondsDuration,
                          curve: Curves.fastOutSlowIn,
                          child: showCropped
                              ? Image.memory(
                                  chooseImageState.croppedImage!.buffer
                                      .asUint8List(),
                                  fit: BoxFit.scaleDown,
                                  width: 340,
                                  height: 340,
                                )
                              : showChosen
                                  ? Cropper(
                                      backgroundColor: Colors.white,
                                      cropperKey: chooseImageState.cropperKey,
                                      overlayType: OverlayType.rectangle,
                                      image: Image.memory(
                                          chooseImageState.chosenImage!),
                                    )
                                  : const SizedBox(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox();
    });
  }
}
