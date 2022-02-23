import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/entry_animation_state.dart';

class TeamIntroduction extends StatelessWidget {
  const TeamIntroduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => injector<EntryAnimationState>().startBreakingGlass(),
          child: const Text(
            'Play demo',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 50,
              fontWeight: FontWeight.w900,
              color: colorsPurpleBluePrimary,
            ),
          ),
        ),
      ),
    );
  }
}
