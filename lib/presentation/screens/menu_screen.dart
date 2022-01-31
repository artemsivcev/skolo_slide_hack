// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/background_with_bubbles.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/glass_container.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu_screen/menu_btns_widget.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundWithBubbles(
        colorsBackground: colorsBackgroundGame,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            //      GlassContainer(
            //        child: Text(
            //          '''Puzzle
            // Game''',
            //          style:
            //              TextStyle(fontFamily: 'LuckiestGuy-Regular', fontSize: 32),
            //        ),
            //      ),
            GlassContainer(child: MenuBtnsWidget()),
          ],
        )));
  }
}
