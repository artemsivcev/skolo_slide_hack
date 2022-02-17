import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/screen_state.dart';

class GameTitle extends StatelessWidget {
  GameTitle({Key? key}) : super(key: key);
  final screenState = injector<ScreenState>();

  @override
  Widget build(BuildContext context) {
    final isWebMobile = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);

    //rotate if a screen width < screen height. only for mobile devices
    final usedMobileVersion = kIsWeb && !isWebMobile
        ? screenState.screenWidth < screenState.screenHeight
        : true;

    return Semantics(
      label: "Game title",
      readOnly: true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
        child: Text(
          usedMobileVersion
              ? 'Slide Puzzle\n      Game'
              : '''Slide
      Puzzle
                 Game''',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: usedMobileVersion ? 20 : 30,
            fontWeight: FontWeight.w900,
            height: 1.3,
            color: colorsPurpleBluePrimary,
          ),
        ),
      ),
    );
  }
}
