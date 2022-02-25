import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/adaptivity_solver/column_row_solver.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/buttons/button_glass.dart';

import 'button_text.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({
    Key? key,
    required this.child,
    required this.isPressed,
    this.btnText = "",
    required this.onTap,
    this.size = 24,
  }) : super(key: key);

  /// child widget
  final Widget child;

  ///Is button pressed
  final bool isPressed;

  ///Button text
  final String btnText;

  ///OnTap function
  final VoidCallback onTap;

  ///btn custom size
  final double size;

  @override
  Widget build(BuildContext context) {
    return ColumnRowSolver(
      children: [
        btnText.isNotEmpty
            ? ButtonText(
                btnText: btnText,
                paddingSize: 10,
                fontSize: 18,
              )
            : const SizedBox(),
        Padding(
          padding: EdgeInsets.zero,
          child: ButtonGlass(
            onTap: onTap,
            size: 10,
            padding: EdgeInsets.zero,
            childUnpressed: SizedBox(
              height: size,
              width: size,
              child: Center(
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
      ],
    );
  }
}
