import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/presentation/screens/new_game_page.dart';
import 'package:skolo_slide_hack/presentation/widgets/buttons/button_widget.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/row_column_solver.dart';

class ButtonsGroupWidget extends StatelessWidget {
  final menuState = injector<MenuState>();

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
          ButtonWidget(
            iconUrl: 'assets/images/puzzle-new-filled.svg',
            btnText: 'New Game',
            isPressed: menuState.newGameBtnPressed,
            onTap: () async {
              menuState.toggleNewGameBtn();
              await Future.delayed(const Duration(milliseconds: 450));
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const NewGamePage(),
                ),
              );
            },
            isHovered: menuState.newGameBtnHovered,
            onHover: (value) {
              menuState.toggleHoveredNewGameBtn();
            },
          ),

          !kIsWeb ? const SizedBox(width: 32) : const SizedBox(),
          !kIsWeb
              ? ButtonWidget(
                  iconUrl: 'assets/images/exit.svg',
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
