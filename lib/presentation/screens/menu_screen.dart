// ignore_for_file: prefer_const_constructors
import 'package:animated_background/lines.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/new_game_state.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';
import 'package:skolo_slide_hack/domain/states/shuffle_animation_state.dart';
import 'package:skolo_slide_hack/domain/states/sound_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/background_with_bubbles.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/glass_container.dart';
import 'package:skolo_slide_hack/presentation/widgets/buttons/buttons_group_widget.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/row_column_solver.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/dash_icon.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/game_title.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/github_icon.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/scolo_icon.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/sound_button.dart';
import 'package:skolo_slide_hack/presentation/widgets/new_game/crop_and_play_buttons.dart';
import 'package:skolo_slide_hack/presentation/widgets/new_game/image_chooser.dart';
import 'package:skolo_slide_hack/presentation/widgets/puzzle_board/puzzle_board_buttons.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/presentation/screens/puzzle_page.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key}) : super(key: key);
  final newGameState = injector<NewGameState>();
  final soundState = injector<SoundState>();
  final puzzleState = injector<PuzzleState>();
  final shuffleAnimationState = injector<ShuffleAnimationState>();

  @override
  Widget build(BuildContext context) {
    soundState.preloadMainAudio();
    return BackgroundWithBubbles(
        colorsBackground: colorsBackgroundGame,
        direction: newGameState.isNewGameShow && !newGameState.isPlayPressed
            ? LineDirection.Ttb
            : LineDirection.Btt,
        child: Stack(
          children: [
            Center(
              child: Observer(
                builder: (context) => RowColumnSolver(
                  children: [
                    GlassContainer(
                      child: AnimatedCrossFade(
                        crossFadeState: newGameState.isNewGameShow &&
                                !newGameState.isPlayPressed
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: animationTwoSecondsDuration,
                        firstChild: ImageChooser(),
                        secondChild: !newGameState.isGameStart
                            ? GameTitle()
                            : PuzzlePage(),
                      ),
                    ),
                    GlassContainer(
                      child: AnimatedCrossFade(
                        crossFadeState: newGameState.isNewGameShow &&
                                !newGameState.isPlayPressed
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: animationTwoSecondsDuration,
                        firstChild: CropAndPlayButton(),
                        secondChild: !newGameState.isGameStart
                            ? ButtonsGroupWidget()
                            : PuzzleBoardButtons(),
                      ),
                    ),
                  ],
                ),
              ),
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
            SoundButton(),
          ],
        ));
  }
}
