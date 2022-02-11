import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/glass_container_circle.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/column_row_solver.dart';

import 'button_text.dart';

class RadioButton extends StatelessWidget {
  RadioButton({
    Key? key,
    required this.child,
    required this.isPressed,
    this.btnText = "",
    required this.onTap,
    required this.isHovered,
    this.size = 24,
    required this.onHover,
  }) : super(key: key);

  /// child widget
  final Widget child;

  ///Is button pressed
  final bool isPressed;

  ///Button text
  final String btnText;

  ///OnTap function
  final VoidCallback onTap;

  ///Checks if button is hovered
  final bool isHovered;

  ///OnHover function
  final ValueChanged<bool> onHover;

  ///btn custom size
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      onHover: onHover,
      child: ColumnRowSolver(
        children: [
          btnText.isNotEmpty
              ? ButtonText(
                  btnText: btnText,
                  paddingSize: 8.0,
                  fontSize: 18,
                )
              : const SizedBox(),
          Padding(
            padding: EdgeInsets.zero,
            child: GlassContainerCircle(
              isHovered: isHovered,
              padding: EdgeInsets.zero,
              blurRadius: 12,
              child: SizedBox(
                height: size,
                width: size,
                child: Center(
                  child: AnimatedOpacity(
                    opacity: isHovered ? 1.0 : 0.7,
                    duration: const Duration(milliseconds: 170),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      child: child,
                      height: isPressed && size - 4 >= 0 ? size - 4 : 0,
                      width: isPressed && size - 4 >= 0 ? size - 4 : 0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
