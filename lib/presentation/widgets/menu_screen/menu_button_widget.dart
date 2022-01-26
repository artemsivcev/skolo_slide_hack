import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu_screen/menu_btn_pressed.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu_screen/menu_btn_unpressed.dart';

class MenuButtonWidget extends StatefulWidget {
  MenuButtonWidget({
    Key? key,
    required this.iconUrl,
    required this.btnText,
    required this.isPressed,
    required this.onTap,
    required this.isHovered,
    required this.onHover,
  }) : super(key: key);

  ///Url for button icon
  final String iconUrl;

  ///Button text
  final String btnText;

  ///Checks if button is pressed
  final bool isPressed;

  ///OnTap function
  final VoidCallback onTap;

  ///Checks if button is hovered
  final bool isHovered;

  ///OnHover function
  final ValueChanged<bool> onHover;

  @override
  _MenuButtonWidgetState createState() => _MenuButtonWidgetState();
}

class _MenuButtonWidgetState extends State<MenuButtonWidget> {
  final menuState = injector<MenuState>();

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 700),
      firstCurve: Curves.easeInQuint,
      secondCurve: Curves.easeInQuint,
      firstChild: MenuBtnUnpressed(
        iconUrl: widget.iconUrl,
        btnText: widget.btnText,
        onTap: widget.onTap,
        onHover: widget.onHover,
        isHovered: widget.isHovered,
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
