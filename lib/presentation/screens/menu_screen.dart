// ignore_for_file: prefer_const_constructors

import 'package:animated_background/lines.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/new_game_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/background_with_bubbles.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/glass_container.dart';
import 'package:skolo_slide_hack/presentation/widgets/buttons/buttons_group_widget.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/row_column_solver.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/dash_icon.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/game_title.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/github_icon.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/scolo_icon.dart';
import 'package:skolo_slide_hack/presentation/widgets/new_game/crop_and_play_buttons.dart';
import 'package:skolo_slide_hack/presentation/widgets/new_game/image_chooser.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key}) : super(key: key);
  final newGameState = injector<NewGameState>();

  //crossfade state for change menu and new game screen
  CrossFadeState newGameFadeState = CrossFadeState.showFirst;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (newGameState.isNewGameShow) {
        newGameFadeState = CrossFadeState.showFirst;
      } else {
        newGameFadeState = CrossFadeState.showSecond;
      }
      return BackgroundWithBubbles(
          colorsBackground: colorsBackgroundGame,
          direction: newGameState.isNewGameShow
              ? LineDirection.Ttb
              : LineDirection.Btt,
          child: Stack(
            children: [
              Center(
                child: RowColumnSolver(children: [
                  GlassContainer(
                    child: AnimatedCrossFade(
                      crossFadeState: newGameFadeState,
                      duration: const Duration(seconds: 2),
                      firstChild: ImageChooser(),
                      secondChild: GameTitle(),
                    ),
                  ),
                  GlassContainer(
                    child: AnimatedCrossFade(
                      crossFadeState: newGameFadeState,
                      duration: const Duration(seconds: 2),
                      firstChild: CropAndPlayButton(),
                      secondChild: ButtonsGroupWidget(),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight - 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    GitHubIcon(),
                    SkoloIcon(),
                  ],
                ),
              ),
              DashIcon(),
            ],
          ));
    });
  }
}
