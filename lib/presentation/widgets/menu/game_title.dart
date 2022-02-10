import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';

import '../text_shadows.dart';

class GameTitle extends StatelessWidget {
  const GameTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Semantics(
        label: "Game title",
        readOnly: true,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            '''Slide
          Puzzle
                    Game''',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 32,
              shadows: TextShadows.generateLongShadow(),
              fontWeight: FontWeight.w900,
              color: colorsPurpleBluePrimary,
            ),
          ),
        ),
      ),
    );
  }
}
