import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/row_column_solver.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu_screen/btns/menu_button_widget.dart';

class MenuBtnsWidget extends StatelessWidget {
  MenuBtnsWidget({Key? key}) : super(key: key);

  final menuState = injector<MenuState>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return RowColumnSolver(
        children: [
          MenuButtonWidget(
            iconUrl: 'assets/images/puzzle-continue.svg',
            btnText: 'Continue',
            isPressed: menuState.continueBtnPressed,
            onTap: () {
              menuState.toggleContinueBtn();
            },
          ),
          const SizedBox(width: 26),
          MenuButtonWidget(
            iconUrl: 'assets/images/puzzle-new-filled.svg',
            btnText: 'New Game',
            isPressed: menuState.newGameBtnPressed,
            onTap: () {
              menuState.toggleNewFameBtn();
            },
          ),
          const SizedBox(width: 26),
          MenuButtonWidget(
            iconUrl: 'assets/images/exit.svg',
            btnText: 'Exit',
            isPressed: menuState.exitBtnPressed,
            onTap: () {
              menuState.toggleExitBtn();
            },
          ),
        ],
      );
    });
  }
}
