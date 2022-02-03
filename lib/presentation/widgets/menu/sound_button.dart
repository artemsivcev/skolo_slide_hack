import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/buttons/button_unpressed_custom.dart';

class SoundButton extends StatelessWidget {
  SoundButton({Key? key}) : super(key: key);

  final menuState = injector<MenuState>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Semantics(
        label: "Turn on/off sound",
        enabled: true,
        child: Observer(builder: (context) {
          return ButtonUnpressedCustom(
            onTap: () => {menuState.toggleSoundBtn()},
            isHovered: menuState.isSoundHovered,
            onHover: (value) {
              menuState.toggleHoveredSound();
            },
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              firstCurve: Curves.easeInQuint,
              secondCurve: Curves.easeInQuint,
              firstChild: const Icon(
                Icons.music_note,
                color: colorsPurpleBluePrimary,
              ),
              secondChild: const Icon(
                Icons.music_off,
                color: colorsPurpleBluePrimary,
              ),
              crossFadeState: menuState.isSoundPlay
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
          );
        }),
      ),
    );
  }
}
