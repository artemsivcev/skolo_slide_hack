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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonGlass(
                size: 18,
                onTap: () => {soundState.toggleSoundBtn()},
                isHovered: buttonsHoverState.isSoundHovered,
                onHover: (value) {
                  buttonsHoverState.toggleHoveredSound();
                },
                childPressed: const Icon(
                  Icons.music_off,
                  size: 18,
                  color: colorsPurpleBluePrimary,
                ),
                childUnpressed: const Icon(
                  Icons.music_note,
                  size: 18,
                  color: colorsPurpleBluePrimary,
                ),
                isPressed: soundState.isSoundPlay,
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              ),
              soundState.isSoundPlay
                  ? SizedBox(
                      height: 16,
                      width: 84,
                      child: Marquee(
                        text: 'Now Playing: Lush World by Tabletop Audio',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colorsPurpleBluePrimary,
                          fontSize: 10,
                        ),
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        blankSpace: 10.0,
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
                      height: 16,
                      width: 84,
                    ),
            ],
          );
        }),
      ),
    );
  }
}
