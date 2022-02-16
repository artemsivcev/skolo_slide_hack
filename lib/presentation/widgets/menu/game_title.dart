import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/screen_state.dart';

import '../text_shadows.dart';

class GameTitle extends StatelessWidget {
  GameTitle({Key? key}) : super(key: key);
  final screenState = injector<ScreenState>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Semantics(
        label: "Game title",
        readOnly: true,
        child: Padding(
          padding:
              EdgeInsets.all(screenState.isPortrait(context) ? 15.0 : 32.0),
          child: Text(
            screenState.isPortrait(context)
                ? 'Slide Puzzle\n      Game'
                : '''Slide
          Puzzle
                    Game''',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: screenState.isPortrait(context) ? 14 : 32,
              fontWeight: FontWeight.w900,
              color: colorsPurpleBluePrimary,
            ),
          ),
        ),
      ),
    );
  }
}
