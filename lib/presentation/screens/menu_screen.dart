// ignore_for_file: prefer_const_constructors

import 'package:animated_background/lines.dart';
import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/background_with_bubbles.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/glass_container.dart';
import 'package:skolo_slide_hack/presentation/widgets/buttons/buttons_group_widget.dart';
import 'package:skolo_slide_hack/presentation/widgets/text_shadows.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundWithBubbles(
        colorsBackground: colorsBackgroundGame,
        direction: LineDirection.Ttb,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            GlassContainer(
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
                  ),
                ),
              ),
            ),
            GlassContainer(child: ButtonsGroupWidget()),
          ],
        )));
  }
}
