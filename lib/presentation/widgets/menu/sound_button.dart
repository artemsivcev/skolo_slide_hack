import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:marquee/marquee.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/buttons_hover_state.dart';
import 'package:skolo_slide_hack/domain/states/sound_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/buttons/button_glass.dart';

class SoundButton extends StatelessWidget {
  SoundButton({Key? key}) : super(key: key);

  final buttonsHoverState = injector<ButtonsHoverState>();
  final soundState = injector<SoundState>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Semantics(
        label: "Turn on/off sound",
        enabled: true,
        child: Observer(builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ButtonGlass(
                size: 25,
                onTap: () => {soundState.toggleSoundBtn()},
                isHovered: buttonsHoverState.isSoundHovered,
                onHover: (value) {
                  buttonsHoverState.toggleHoveredSound();
                },
                childPressed: const Icon(
                  Icons.music_off,
                  color: colorsPurpleBluePrimary,
                ),
                childUnpressed: const Icon(
                  Icons.music_note,
                  color: colorsPurpleBluePrimary,
                ),
                isPressed: soundState.isSoundPlay,
                padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 8.0),
              ),
              soundState.isSoundPlay
                  ? SizedBox(
                      height: 24,
                      width: 114,
                      child: Marquee(
                        text: 'Now Playing: Lush World by Tabletop Audio',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        blankSpace: 20.0,
                        velocity: 100.0,
                        pauseAfterRound: const Duration(seconds: 1),
                        startPadding: 10.0,
                        accelerationDuration: const Duration(seconds: 1),
                        accelerationCurve: Curves.linear,
                        decelerationDuration: const Duration(milliseconds: 500),
                        decelerationCurve: Curves.easeOut,
                      ),
                    )
                  : const SizedBox(
                      height: 24,
                    ),
            ],
          );
        }),
      ),
    );
  }
}
