import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/glass_container.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/row_column_solver.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/buttons_group_widget.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/game_title.dart';
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
    return Center(
      child: FittedBox(
        child: Observer(
          builder: (context) {
            var isStart = !menuState.isShowGame && !menuState.isShowImagePicker;

            return RowColumnSolver(
              children: [
                GlassContainer(
                  innerPadding: isStart ? EdgeInsets.zero : null,
                  child: AnimatedCrossFade(
                    crossFadeState: isStart
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: animationTwoSecondsDuration,
                    firstChild: DifficultyLevel(),
                    secondChild: menuState.isShowGame
                        ? const PuzzlePage()
                        : const ImageChooser(),
                  ),
                ),
                FittedBox(
                  child: GlassContainer(
                    child: AnimatedCrossFade(
                      crossFadeState: isStart
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: animationTwoSecondsDuration,
                      firstChild: ButtonsGroupWidget(),
                      secondChild: menuState.isShowGame
                          ? PuzzleBoardButtons()
                          : const CropButtons(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
