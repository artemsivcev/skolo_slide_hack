import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/enums/difficulty_level_enum.dart';
import 'package:skolo_slide_hack/domain/states/new_game_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/new_game/difficulty_button.dart';
import '../text_shadows.dart';

class DifficultyLevel extends StatelessWidget {
  final newGameState = injector<NewGameState>();

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
              shadows: TextShadows.generateLongShadow(),
              fontWeight: FontWeight.w900,
              height: 1.4,
              color: colorsPurpleBluePrimary,
            ),
          ),
        ),
        Observer(
          builder: (context) {
            var difficultyLevel = newGameState.difficultyLevel;

            return Row(
              children: [
                DifficultyButton(
                  semanticLabel: 'Easy',
                  dimensions: '3x3',
                  isSelected: difficultyLevel == DifficultyLevelEnum.EASY,
                  onTap: () =>
                      newGameState.changeDifficulty(DifficultyLevelEnum.EASY),
                  isHovered: newGameState.isEasyLevelHovered,
                  onHover: (value) => newGameState.toggleHoveredEasyLevel(),
                ),
                const SizedBox(width: 12),
                DifficultyButton(
                  semanticLabel: 'Middle',
                  dimensions: '4x4',
                  isSelected: difficultyLevel == DifficultyLevelEnum.MIDDLE,
                  onTap: () =>
                      newGameState.changeDifficulty(DifficultyLevelEnum.MIDDLE),
                  isHovered: newGameState.isMiddleLevelHovered,
                  onHover: (value) => newGameState.toggleHoveredMiddleLevel(),
                ),
                const SizedBox(width: 12),
                DifficultyButton(
                  semanticLabel: 'Hard',
                  dimensions: '5x5',
                  isSelected: difficultyLevel == DifficultyLevelEnum.HARD,
                  onTap: () =>
                      newGameState.changeDifficulty(DifficultyLevelEnum.HARD),
                  isHovered: newGameState.isHardLevelHovered,
                  onHover: (value) => newGameState.toggleHoveredHardLevel(),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}