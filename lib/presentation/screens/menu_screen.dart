// ignore_for_file: prefer_const_constructors

import 'package:animated_background/lines.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/background_with_bubbles.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/glass_container.dart';
import 'package:skolo_slide_hack/presentation/widgets/buttons/buttons_group_widget.dart';
import 'package:skolo_slide_hack/presentation/widgets/text_shadows.dart';
import 'package:url_launcher/url_launcher.dart';

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
            InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async => {
               launch("https://github.com/artemsivcev/skolo_slide_hack")
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/github.png',
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
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
                    fontWeight: FontWeight.w900,
                    color: colorsPurpleBluePrimary,
                  ),
                ),
              ),
            ),
            Spacer(),
            GlassContainer(child: ButtonsGroupWidget()),
            Spacer(
              flex: 2,
            ),
            InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async => {
                launch("https://flutter.com")
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'assets/images/dash.png',
                  width: 210,
                ),
              ),
            ),
          ],
        )));
  }
}
