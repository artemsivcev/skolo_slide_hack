import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:marquee/marquee.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/screen_state.dart';
import 'package:skolo_slide_hack/domain/states/sound_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/buttons/button_glass.dart';

class SoundButton extends StatelessWidget {
  SoundButton({Key? key}) : super(key: key);

  final soundState = injector<SoundState>();
  final screenState = injector<ScreenState>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Semantics(
        label: "Turn on/off sound",
        enabled: true,
        child: Observer(builder: (context) {
          var usedMobileVersion = screenState.usedMobileVersion;

          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonGlass(
                size: usedMobileVersion ? 14 : 20,
                onTap: () => {soundState.toggleSoundBtn()},
                childPressed: Icon(
                  Icons.music_off,
                  size: usedMobileVersion ? 16 : 20,
                  color: colorsPurpleBluePrimary,
                ),
                childUnpressed: Icon(
                  Icons.music_note,
                  size: usedMobileVersion ? 16 : 20,
                  color: colorsPurpleBluePrimary,
                ),
                isPressed: soundState.isSoundPlay,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 2),
              ),
              soundState.isSoundPlay
                  ? Container(
                      height: usedMobileVersion ? 12 : 20,
                      width: 82,
                      padding: const EdgeInsets.only(right: 4),
                      child: Marquee(
                        text: 'Now Playing: Lush World by Tabletop Audio',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colorsPurpleBluePrimary,
                          fontSize: usedMobileVersion ? 9 : 14,
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
                  : SizedBox(
                      height: usedMobileVersion ? 12 : 20,
                      width: 82,
                    ),
            ],
          );
        }),
      ),
    );
  }
}
