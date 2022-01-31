import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/presentation/screens/new_game_page.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu_screen/menu_button_widget.dart';

class MenuBtnsWidget extends StatelessWidget {
  final menuState = injector<MenuState>();
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MenuButtonWidget(
            iconUrl: 'assets/images/puzzle-continue.svg',
            btnText: 'Continue',
            isPressed: menuState.continueBtnPressed,
            onTap: () {
              menuState.togglePressedBtn(0);
            },
            isHovered: menuState.continueBtnHovered,
            onHover: (value) {
              menuState.toggleHoveredBtn(0);
            },
          ),
          const SizedBox(width: 26),
          MenuButtonWidget(
            iconUrl: 'assets/images/puzzle-new-filled.svg',
            btnText: 'New Game',
            isPressed: menuState.newGameBtnPressed,
            onTap: () async {
              menuState.togglePressedBtn(1);
              await Future.delayed(const Duration(milliseconds: 1500));
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const NewGamePage(),
                ),
              );
            },
            isHovered: menuState.newGameBtnHovered,
            onHover: (value) {
              menuState.toggleHoveredBtn(1);
            },
          ),
          const SizedBox(width: 26),
          MenuButtonWidget(
            iconUrl: 'assets/images/exit.svg',
            btnText: 'Exit',
            isPressed: menuState.exitBtnPressed,
            onTap: () {
              menuState.togglePressedBtn(2);
            },
            isHovered: menuState.exitBtnHovered,
            onHover: (value) {
              menuState.toggleHoveredBtn(2);
            },
          ),
        ],
      );
    });
  }
}
