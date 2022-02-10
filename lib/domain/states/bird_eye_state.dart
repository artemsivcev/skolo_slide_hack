import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/screen_state.dart';

part 'bird_eye_state.g.dart';

class BirdEyeState = _BirdEyeState with _$BirdEyeState;

/// State is used for animating bird eyes
/// when moving mouse cursor.
abstract class _BirdEyeState with Store {
  /// need to access to sounds
  final screenState = injector<ScreenState>();

  /// todo update owl eyes location
  /// top left - 1.0 1.0
  /// bottom left - 1.0 1.01
  /// bottom right - 1.01 1.01
  /// top right - 1.01 1.0
  /// center - 1.005, 1.005
  @observable
  double eyeX = 1.005;
  @observable
  double eyeY = 1.005;

  /// default eyes location (center)
  @action
  void resetEyesLocation(PointerEvent details) {
    eyeX = 1.005;
    eyeY = 1.005;
  }

  @action
  void updateEyesLocation(PointerEvent details) {
    var x = details.position.dx;
    var y = details.position.dy;

    if (y > screenState.screenHeight * 0.9) {
      /// its below owl
      eyeY = 1.01;
    } else {
      ///its upper owl
      eyeY = 1.0;
    }

    if (x < screenState.screenWidth * 0.9) {
      ///x left from owl
      eyeX = 1.0;
    } else {
      /// from right of owl
      eyeX = 1.01;
    }
  }
}
