import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/domain/states/buttons_hover_state.dart';
import 'package:skolo_slide_hack/domain/states/choose_image_state.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/buttons/button_glass.dart';

class CropButtons extends StatefulWidget {
  const CropButtons({Key? key}) : super(key: key);

  @override
  _CropButtonsState createState() => _CropButtonsState();
}

class _CropButtonsState extends State<CropButtons>
    with TickerProviderStateMixin {
  final chooseImageState = injector<ChooseImageState>();
  final buttonsHoverState = injector<ButtonsHoverState>();
  final menuState = injector<MenuState>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Row(
        children: [
          ButtonGlass(
            childUnpressed: const Icon(
              Icons.arrow_back,
              size: 50.0,
              color: colorsPurpleBluePrimary,
            ),
            btnText: 'Back',
            onTap: () async => menuState.backToMenu(),
            isHovered: buttonsHoverState.isBackHover,
            onHover: (value) => buttonsHoverState.toggleBackHover(),
          ),
          AnimatedCrossFade(
            crossFadeState: chooseImageState.chosenImage != null
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: animationTwoSecondsDuration,
            firstChild: Semantics(
              label: "Crop your image to square",
              enabled: true,
              child: ButtonGlass(
                childUnpressed: SvgPicture.asset(
                  'assets/images/puzzle-new.svg',
                  color: colorsPurpleBluePrimary,
                ),
                btnText: 'Crop & Play!',
                onTap: () async {
                  chooseImageState.splitImageAndPlay();
                },
                isHovered: buttonsHoverState.isCropHovered,
                onHover: (value) {
                  buttonsHoverState.toggleHoveredCrop();
                },
              ),
            ),
            secondChild: const SizedBox(),
          ),
        ],
      );
    });
  }
}
