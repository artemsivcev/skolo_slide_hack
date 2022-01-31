import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';

import '../../text_shadows.dart';

class BtnText extends StatelessWidget {
  BtnText({Key? key, required this.btnText}) : super(key: key);

  final String btnText;
  final menuState = injector<MenuState>();

  @override
  Widget build(BuildContext context) {
    var isPortrait = menuState.isPortrait(context);
    return Padding(
      padding: isPortrait
          ? const EdgeInsets.fromLTRB(0.0, 32.0, 32.0, 32.0)
          : const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 32.0),
      child: Text(
        btnText,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: colorsGreyLightPrimary,
          shadows: TextShadows.generateLongShadow(),
        ),
      ),
    );
  }
}
