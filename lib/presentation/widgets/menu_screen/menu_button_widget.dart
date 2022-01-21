import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu_screen/menu_btn_pressed.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu_screen/menu_btn_unpressed.dart';

class MenuButtonWidget extends StatefulWidget {
  MenuButtonWidget(
      {Key? key,
      required this.iconUrl,
      required this.btnText,
      required this.isPressed,
      required this.onTap})
      : super(key: key);

  ///Url for button icon
  final String iconUrl;

  ///Button text
  final String btnText;

  ///Checks if button is pressed
  final bool isPressed;

  ///OnTap function
  final VoidCallback onTap;

  @override
  _MenuButtonWidgetState createState() => _MenuButtonWidgetState();
}

class _MenuButtonWidgetState extends State<MenuButtonWidget> {
  final menuState = injector<MenuState>();

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 1500),
      firstCurve: Curves.easeInQuint,
      secondCurve: Curves.easeInQuint,
      firstChild: MenuBtnUnpressed(
        iconUrl: widget.iconUrl,
        btnText: widget.btnText,
        onTap: widget.onTap,
      ),
      secondChild: MenuBtnPressed(
        iconUrl: widget.iconUrl,
        btnText: widget.btnText,
        onTap: widget.onTap,
      ),
      crossFadeState: widget.isPressed
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
    );
  }
}
