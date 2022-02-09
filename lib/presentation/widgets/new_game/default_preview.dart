import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/domain/states/choose_image_state.dart';

class DefaultPreview extends StatelessWidget {
  DefaultPreview({Key? key, required this.imageIndex}) : super(key: key);

  int imageIndex = 0;

  final chooseImageState = injector<ChooseImageState>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      var defaultImageName = "cat";
      if (imageIndex == 0) {
        defaultImageName = "cat";
      } else if (imageIndex == 1) {
        defaultImageName = "dog";
      } else if (imageIndex == 2) {
        defaultImageName = "city";
      } else {
        defaultImageName = "cat";
      }

      var isChosen = chooseImageState.chosenImageNumber == imageIndex;
      var showOthers = true;
      if (isChosen) {
        showOthers = true;
      } else {
        showOthers = chooseImageState.croppedImage == null;
      }

      return showOthers
          ? InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async => {
                await chooseImageState.chooseImage(
                    defaultImageName, imageIndex),
                await Future.delayed(const Duration(seconds: 2)),
                chooseImageState.splitDefaultImageAndPlay(),
              },
              child: Semantics(
                label: "Choose $defaultImageName image",
                enabled: true,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: AnimatedContainer(
                        width: chooseImageState.getAnimatedContainerSize(
                            context, isChosen),
                        height: chooseImageState.getAnimatedContainerSize(
                            context, isChosen),
                        duration: animationTwoSecondsDuration,
                        curve: Curves.fastOutSlowIn,
                        child: Image.asset(
                          'assets/images/default/$defaultImageName.png',
                          width: chooseImageState.getImageMaxSize(
                            context,
                          ),
                          height: chooseImageState.getImageMaxSize(context),
                        ),
                      )),
                ),
              ),
            )
          : const SizedBox();
    });
  }
}
