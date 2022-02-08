/// enums for detecting the difficulty level of the game
enum DifficultyLevelEnum {
  EASY,
  MIDDLE,
  HARD,
}

/// get border size, which depends on
/// the difficulty level selected by the user.
int getBorderSizeDependingOnDifficulty(DifficultyLevelEnum value) {
  switch (value) {
    case DifficultyLevelEnum.EASY:
      return 3;
    case DifficultyLevelEnum.MIDDLE:
      return 4;
    case DifficultyLevelEnum.HARD:
      return 5;
  }
}
