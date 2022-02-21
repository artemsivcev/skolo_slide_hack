import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/glass_container.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/adaptivity_solver/row_column_solver.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/buttons_group_widget.dart';
import 'package:skolo_slide_hack/presentation/widgets/new_game/crop_buttons.dart';
import 'package:skolo_slide_hack/presentation/widgets/new_game/difficulty_level.dart';
import 'package:skolo_slide_hack/presentation/widgets/new_game/image_chooser.dart';
import 'package:skolo_slide_hack/presentation/widgets/puzzle_board/puzzle_board_buttons.dart';
import 'package:skolo_slide_hack/presentation/widgets/puzzle_board/puzzle_page.dart';

class MenuWidget extends StatelessWidget {
  MenuWidget({Key? key}) : super(key: key);
  final menuState = injector<MenuState>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: FittedBox(
          child: Observer(
            builder: (context) {
              Widget firstWidgetToShow = const SizedBox();
              Widget secondWidgetToShow = const SizedBox();

              switch (menuState.currentGameState) {
                case GameState.CHOSE_IMAGE:
                  firstWidgetToShow = const ImageChooser();
                  secondWidgetToShow = const CropButtons();
                  break;

                case GameState.WITHOUT_IMAGE_PLAY:
                case GameState.DEFAULT_IMAGE_PLAY:
                case GameState.CUSTOM_IMAGE_PLAY:
                  firstWidgetToShow = const PuzzlePage();
                  secondWidgetToShow = PuzzleBoardButtons();
                  break;

                // as for GameState.MAIN_MENU
                default:
                  firstWidgetToShow = DifficultyLevel();
                  secondWidgetToShow = ButtonsGroupWidget();
              }

              return RowColumnSolver(
                children: [
                  GlassContainer(
                    child: AnimatedCrossFade(
                      crossFadeState: CrossFadeState.showFirst,
                      duration: animationTwoSecondsDuration,
                      firstChild: firstWidgetToShow,
                      secondChild: secondWidgetToShow,
                    ),
                  ),
                  FittedBox(
                    child: GlassContainer(
                      child: AnimatedCrossFade(
                        crossFadeState: CrossFadeState.showFirst,
                        duration: animationTwoSecondsDuration,
                        firstChild: secondWidgetToShow,
                        secondChild: secondWidgetToShow,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
