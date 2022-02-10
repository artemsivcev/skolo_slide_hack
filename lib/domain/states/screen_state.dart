import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'screen_state.g.dart';

class ScreenState = _ScreenState with _$ScreenState;

abstract class _ScreenState with Store {
  //function help's to understand current user orientation by screen aspect ratio
  bool isPortrait(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return height > width;
  }

  double screenWidth = 0;
  double screenHeight = 0;

  @action
  void setScreenSize(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
}
