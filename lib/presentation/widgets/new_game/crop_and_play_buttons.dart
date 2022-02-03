import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/domain/states/new_game_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/buttons/button_glass.dart';

class CropAndPlayButton extends StatefulWidget {
  const CropAndPlayButton({Key? key}) : super(key: key);

  @override
  _CropAndPlayButtonState createState() => _CropAndPlayButtonState();
}

class _CropAndPlayButtonState extends State<CropAndPlayButton>
    with TickerProviderStateMixin {
  final newGameState = injector<NewGameState>();

  //crossfade state for buttons crop and play logic
  CrossFadeState crossStateButtons = CrossFadeState.showFirst;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (newGameState.chosenImage != null) {
        crossStateButtons = CrossFadeState.showFirst;
      } else {
        crossStateButtons = CrossFadeState.showSecond;
      }
      return AnimatedCrossFade(
        crossFadeState: crossStateButtons,
        duration: animationTwoSecondsDuration,
        firstChild: Semantics(
          label: "Crop your image to square",
          enabled: true,
          child: ButtonGlass(
            childUnpressed: SvgPicture.asset(
              'assets/images/puzzle-new.svg',
              color: colorsPurpleBluePrimary,
            ),
            btnText: 'Crop!',
            isPressed: newGameState.isCropPressed,
            onTap: () async {
              newGameState.cropImage();
            },
            isHovered: newGameState.isCropHovered,
            onHover: (value) {
              newGameState.toggleHoveredCrop();
            },
          ),
        ),
        secondChild: Semantics(
          label: "Go to game page",
          enabled: true,
          child: ButtonGlass(
            childUnpressed: SvgPicture.asset(
              'assets/images/puzzle-new-filled.svg',
              color: colorsPurpleBluePrimary,
            ),
            btnText: 'Play!',
            isPressed: newGameState.isPlayPressed,
            onTap: () async {
              await newGameState.playPress();
            },
            isHovered: newGameState.isPlayHovered,
            onHover: (value) {
              newGameState.toggleHoveredPlay();
            },
          ),
        ),
      );
    });
  }
}
