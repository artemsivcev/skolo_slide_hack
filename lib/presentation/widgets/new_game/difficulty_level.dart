import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/enums/difficulty_level_enum.dart';
import 'package:skolo_slide_hack/domain/states/buttons_hover_state.dart';
import 'package:skolo_slide_hack/domain/states/difficulty_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/new_game/difficulty_button.dart';

import '../text_shadows.dart';

class DifficultyLevel extends StatelessWidget {
  final difficultyState = injector<DifficultyState>();
  final buttonsHoverState = injector<ButtonsHoverState>();

  DifficultyLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: Text(
            'Difficulty level',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 24,
              fontWeight: FontWeight.w900,
              height: 1.4,
              color: colorsPurpleBluePrimary,
            ),
          ),
        ),
        Observer(
          builder: (context) {
            var difficultyLevel = difficultyState.difficultyLevel;

            return Row(
              children: [
                DifficultyButton(
                  semanticLabel: 'Easy',
                  dimensions: '3x3',
                  isSelected: difficultyLevel == DifficultyLevelEnum.EASY,
                  onTap: () => difficultyState
                      .changeDifficulty(DifficultyLevelEnum.EASY),
                  isHovered: buttonsHoverState.isEasyLevelHovered,
                  onHover: (value) =>
                      buttonsHoverState.toggleHoveredEasyLevel(),
                ),
                const SizedBox(width: 12),
                DifficultyButton(
                  semanticLabel: 'Middle',
                  dimensions: '4x4',
                  isSelected: difficultyLevel == DifficultyLevelEnum.MIDDLE,
                  onTap: () => difficultyState
                      .changeDifficulty(DifficultyLevelEnum.MIDDLE),
                  isHovered: buttonsHoverState.isMiddleLevelHovered,
                  onHover: (value) =>
                      buttonsHoverState.toggleHoveredMiddleLevel(),
                ),
                const SizedBox(width: 12),
                DifficultyButton(
                  semanticLabel: 'Hard',
                  dimensions: '5x5',
                  isSelected: difficultyLevel == DifficultyLevelEnum.HARD,
                  onTap: () => difficultyState
                      .changeDifficulty(DifficultyLevelEnum.HARD),
                  isHovered: buttonsHoverState.isHardLevelHovered,
                  onHover: (value) =>
                      buttonsHoverState.toggleHoveredHardLevel(),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
