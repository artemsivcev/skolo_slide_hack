import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'screen_state.g.dart';

class ScreenState = _ScreenState with _$ScreenState;

/// State is used for detecting screen dimensions (width and height)
abstract class _ScreenState with Store {
  /// function help's to understand current user orientation by screen aspect ratio
  bool isPortrait(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return height > width;
  }

  @observable
  double screenWidth = 0;

  @observable
  double screenHeight = 0;

  @action
  void setScreenSize(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  @computed
  bool get usedMobileVersion {
    final isWebMobile = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);

    //rotate if a screen width < screen height. only for mobile devices
    return kIsWeb && !isWebMobile ? screenWidth < screenHeight : true;
  }
}
