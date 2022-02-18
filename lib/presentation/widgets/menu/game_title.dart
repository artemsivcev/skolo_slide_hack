import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/screen_state.dart';

class GameTitle extends StatelessWidget {
  GameTitle({Key? key}) : super(key: key);
  final screenState = injector<ScreenState>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        var usedMobileVersion = screenState.usedMobileVersion;

        return Semantics(
          label: "Game title",
          readOnly: true,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
            child: Text(
              usedMobileVersion
                  ? 'Slide Puzzle\n      Game'
                  : '''Slide
        Puzzle
                   Game''',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: usedMobileVersion ? 18 : 30,
                fontWeight: FontWeight.w900,
                height: 1.4,
                color: colorsPurpleBluePrimary,
              ),
            ),
          ),
        );
      },
    );
  }
}
