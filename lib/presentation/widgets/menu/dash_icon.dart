import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/bird_eye_state.dart';
import 'package:url_launcher/url_launcher.dart';

class DashIcon extends StatelessWidget {
  DashIcon({Key? key}) : super(key: key);
  final birdEyeState = injector<BirdEyeState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Image.asset(
          'assets/images/dash_without_eyes.png',
          width: 105,
        ),
        Observer(builder: (context) {
          return AnimatedAlign(
            alignment: Alignment(birdEyeState.eyeX, birdEyeState.eyeY),
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOutBack,
            child: Semantics(
              label: "Image of Dash and link to flutter website",
              enabled: true,
              child: InkWell(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async => {launch("https://flutter.com")},
                child: Image.asset(
                  'assets/images/dash_eyes.png',
                  width: 105,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
