import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/buttons/button_pressed.dart';
import 'package:skolo_slide_hack/presentation/widgets/buttons/button_unpressed.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({
    Key? key,
    required this.iconUrl,
    required this.btnText,
    required this.isPressed,
    required this.onTap,
    this.isHovered = true,
    this.onHover,
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
  final ValueChanged<bool>? onHover;

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  final menuState = injector<MenuState>();

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      firstCurve: Curves.easeInQuint,
      secondCurve: Curves.easeInQuint,
      firstChild: ButtonUnpressed(
        iconUrl: widget.iconUrl,
        btnText: widget.btnText,
        onTap: widget.onTap,
        onHover: widget.onHover ?? (value) {},
        isHovered: widget.isHovered,
      ),
      secondChild: ButtonPressed(
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
