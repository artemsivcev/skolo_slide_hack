import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';
import 'package:skolo_slide_hack/domain/states/start_animation_state.dart';

part 'adaptive_dimensions_state.g.dart';

class AdaptiveDimensionsState = _AdaptiveDimensionsState
    with _$AdaptiveDimensionsState;

abstract class _AdaptiveDimensionsState with Store {
  final puzzleState = injector<PuzzleState>();

  final startAnimationState = injector<StartAnimationState>();

  Size getAdaptiveBoardSize(BuildContext context) {
    final screenSize = getScreenSizeByContext(context);

    var resultWidth = 310.0;
    var resultHeight = 310.0;

    if (puzzleState.isComplete) {
      resultWidth += 38.0;
      resultHeight += 38.0;
    }

    if (!kIsWeb) {
      if (screenSize.width ~/ screenSize.height > 0) {
        resultWidth -= 20.0;
        resultHeight -= 20.0;
      }
    }

    return Size(resultWidth, resultHeight);
  }

  Size getScreenSizeByContext(BuildContext context) =>
      MediaQuery.of(context).size;

  bool isWidthMoreThenHeight(Size screenSize) =>
      screenSize.width > screenSize.height;
}
