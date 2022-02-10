import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/domain/enums/difficulty_level_enum.dart';

part 'difficulty_state.g.dart';

class DifficultyState = _DifficultyState with _$DifficultyState;

/// State is used for choosing the level of difficulty. Depending on its value,
/// we have a board size with the corresponding difficult.
abstract class _DifficultyState with Store {
  /// selected difficulty level of the game
  @observable
  DifficultyLevelEnum difficultyLevel = DifficultyLevelEnum.EASY;

  /// size of board (if dimensions are 4x4, size is 4)
  @computed
  int get boardSize => getBorderSizeDependingOnDifficulty(difficultyLevel);

  /// change boarder size
  @action
  void changeDifficulty(DifficultyLevelEnum value) => difficultyLevel = value;

  void dispose() {
    //todo move to back btn
    // difficultyLevel = DifficultyLevelEnum.EASY;
    // isBtnChooseImagePressed = false;
    // isCropPressed = false;
    // isPlayPressed = false;
    // isCropHovered = false;
    // isPlayHovered = false;
    // chosenImage = null;
    // croppedImage = null;
    // imageMap = null;
    // isGameStart = false;
    // isNewGameShow = false;
    // isEasyLevelHovered = false;
    // isMiddleLevelHovered = false;
    // isHardLevelHovered = false;
    // eyeX = 1.005;
    // eyeY = 1.005;
  }
}
