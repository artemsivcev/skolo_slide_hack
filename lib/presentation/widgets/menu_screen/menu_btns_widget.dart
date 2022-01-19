import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu_screen/menu_button_widget.dart';

class MenuBtnsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        MenuButtonWidget(
            iconUrl: 'assets/images/puzzle-continue.svg', btnText: 'Continue'),
        SizedBox(width: 90),
        MenuButtonWidget(
            iconUrl: 'assets/images/puzzle-new-filled.svg',
            btnText: 'New Game'),
        SizedBox(width: 90),
        MenuButtonWidget(iconUrl: 'assets/images/exit.svg', btnText: 'Exit'),
      ],
    );
  }
}
