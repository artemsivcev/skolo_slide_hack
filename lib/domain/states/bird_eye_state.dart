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

  /// owl eyes location matrix
  /// top center -  0.95, 0.99
  /// top left - 0.8,  0.99
  /// bottom left - 0.8, 1.01
  /// bottom right - 1.2, 1.01
  /// top right - 1.2,  0.99
  /// center - 0.95, 1.001
  /// botom center -  0.95, 1.01
  @observable
  double eyeX = 0.95;
  @observable
  double eyeY = 1.001;

  /// default eyes location (center)
  @action
  void resetEyesLocation(PointerEvent details) {
    eyeX = 0.95;
    eyeY = 1.001;
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
      eyeY = 0.99;
    }

    if (x < screenState.screenWidth * 0.9) {
      ///x left from owl
      eyeX = 0.8;
    } else {
      /// from right of owl
      eyeX = 1.2;
    }
  }
}
