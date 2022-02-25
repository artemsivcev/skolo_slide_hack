import 'package:animated_background/lines.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/domain/states/screen_state.dart';
import 'package:skolo_slide_hack/domain/states/sound_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/background_with_bubbles.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/dash_icon.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/game_title.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/links_row.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/menu_widget.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/sound_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final menuState = injector<MenuState>();
  final soundState = injector<SoundState>();
  final screenState = injector<ScreenState>();

  @override
  Widget build(BuildContext context) {
    soundState.preloadMainAudio();
    screenState.setScreenSize(context);
    return Container(
      color: colorsBackgroundGame,
      child: Observer(builder: (context) {
        final mainMenuIsShowing =
            menuState.currentGameState == GameState.MAIN_MENU;
        final chooseImageIsShowing =
            menuState.currentGameState == GameState.CHOSE_IMAGE;

        return Material(
          child: Container(
            color: colorsBackgroundGame,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedOpacity(
                  opacity: mainMenuIsShowing || chooseImageIsShowing ? 1.0 : 0,
                  duration: const Duration(seconds: 3),
                  child: SizedBox(
                      width: screenState.screenWidth,
                      height: screenState.screenHeight,
                      child: BackgroundWithBubbles(
                          colorsBackground: colorsBackgroundGame,
                          direction: mainMenuIsShowing
                              ? LineDirection.Ttb
                              : LineDirection.Btt,
                          numLines: 20,
                          child: Container())),
                ),
                SafeArea(
                  bottom: false,
                  left: false,
                  right: false,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: SoundButton(),
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: GameTitle(),
                          ),
                          MenuWidget(),
                          LinksRow(),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: DashIcon(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
