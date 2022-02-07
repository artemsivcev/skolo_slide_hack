import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/domain/states/new_game_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/row_column_solver.dart';

import 'button_glass.dart';

class ButtonsGroupWidget extends StatelessWidget {
  final menuState = injector<MenuState>();
  final newGameState = injector<NewGameState>();

  ButtonsGroupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return RowColumnSolver(
        children: [
          // ButtonWidget(
          //   iconUrl: 'assets/images/puzzle-continue.svg',
          //   btnText: 'Continue',
          //   isPressed: menuState.continueBtnPressed,
          //   onTap: () {
          //     menuState.toggleContinueBtn();
          //   },
          //   isHovered: menuState.continueBtnHovered,
          //   onHover: (value) {
          //     menuState.toggleHoveredContinueBtn();
          //   },
          // ),
          // const SizedBox(width: 32),
          Semantics(
            label: "Go to image chooser",
            enabled: true,
            child: ButtonGlass(
              childUnpressed: SvgPicture.asset(
                'assets/images/puzzle-new-filled.svg',
                color: colorsPurpleBluePrimary,
              ),
              btnText: 'New Game',
              isPressed: menuState.newGameBtnPressed,
              onTap: () async {
                menuState.toggleNewGameBtn();
                await Future.delayed(const Duration(milliseconds: 450));
                newGameState.isNewGameShow = true;
              },
              isHovered: menuState.newGameBtnHovered,
              onHover: (value) {
                menuState.toggleHoveredNewGameBtn();
              },
            ),
          ),

          !kIsWeb ? const SizedBox(width: 32) : const SizedBox(),
          !kIsWeb
              ? ButtonGlass(
                  childUnpressed: SvgPicture.asset(
                    'assets/images/exit.svg',
                    color: colorsPurpleBluePrimary,
                    height: 40,
                  ),
                  btnText: 'Exit',
                  isPressed: menuState.exitBtnPressed,
                  onTap: () {
                    menuState.toggleExitBtn();
                  },
                  isHovered: menuState.exitBtnHovered,
                  onHover: (value) {
                    menuState.toggleHoveredExitBtn();
                  },
                )
              : const SizedBox(),
        ],
      );
    });
  }
}
