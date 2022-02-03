import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/new_game_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/buttons/button_widget.dart';

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
        duration: const Duration(seconds: 2),
        firstChild: Semantics(
          label: "Crop your image to square",
          enabled: true,
          child: ButtonWidget(
            iconUrl: 'assets/images/puzzle-new.svg',
            btnText: 'Crop!',
            isPressed: false,
            onTap: () async {
              newGameState.cropImage();
            },
          ),
        ),
        secondChild: Semantics(
          label: "Go to game page",
          enabled: true,
          child: ButtonWidget(
            iconUrl: 'assets/images/puzzle-new-filled.svg',
            btnText: 'Play!',
            isPressed: false,
            onTap: () async {
              await newGameState.playPress();
            },
          ),
        ),
      );
    });
  }
}
