import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/domain/states/choose_image_state.dart';

class DefaultPreview extends StatelessWidget {
  DefaultPreview({Key? key, required this.imageIndex}) : super(key: key);

  final int imageIndex;

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

      final anyImageNotChosenYet = !chooseImageState.chosenCustomImage &&
          !chooseImageState.chosenDefaultImage;

      final isChosen = chooseImageState.chosenImageNumber == imageIndex;
      final showThisImage = isChosen || anyImageNotChosenYet;

      return showThisImage
          ? InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async => {
                await chooseImageState.chooseDefaultImage(
                    defaultImageName, imageIndex),
              },
              child: Semantics(
                label: "Choose $defaultImageName image",
                enabled: true,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
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
