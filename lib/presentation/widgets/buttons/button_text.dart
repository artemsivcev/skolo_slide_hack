import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/screen_state.dart';

class ButtonText extends StatelessWidget {
  ButtonText({
    Key? key,
    required this.btnText,
    this.paddingSize = 20.0,
    this.fontSize,
  }) : super(key: key);

  final String btnText;
  final screenState = injector<ScreenState>();
  final double paddingSize;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    var isPortrait = screenState.isPortrait(context);
    return Padding(
      padding: isPortrait
          ? EdgeInsets.fromLTRB(0.0, paddingSize, paddingSize, paddingSize)
          : EdgeInsets.fromLTRB(paddingSize, 0.0, paddingSize, paddingSize),
      child: Text(
        btnText,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: fontSize ?? 23,
          fontWeight: FontWeight.w900,
          color: colorsPurpleBluePrimary,
        ),
      ),
    );
  }
}
