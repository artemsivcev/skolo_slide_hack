import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/glass_container_circle.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/column_row_solver.dart';

import 'button_text.dart';

class ButtonGlass extends StatelessWidget {
  ButtonGlass({
    Key? key,
    required this.childUnpressed,
    this.childPressed,
    required this.isPressed,
    this.btnText = "",
    required this.onTap,
    required this.isHovered,
    this.size = 50,
    this.onHover,
    this.padding,
  }) : super(
          key: key,
        );

  ///Widget for unpressed button
  final Widget childUnpressed;

  ///Widget for pressed button
  Widget? childPressed;

  ///Is button pressed
  final bool isPressed;

  ///Button text
  String? btnText = "";

  ///OnTap function
  final VoidCallback onTap;

  ///Checks if button is hovered
  final bool isHovered;

  ///OnHover function
  ValueChanged<bool>? onHover = (value) {};

  ///btn custom size
  final double size;

  ///btn custom padding
  EdgeInsetsGeometry? padding = const EdgeInsets.all(32.0);

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
          Padding(
            padding: padding ?? const EdgeInsets.all(32.0),
            child: GlassContainerCircle(
              isHovered: isHovered,
              child: SizedBox(
                height: size,
                width: size,
                child: Center(
                  child: AnimatedOpacity(
                    opacity: isHovered ? 1.0 : 0.7,
                    duration: const Duration(milliseconds: 170),
                    child: AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      firstCurve: Curves.easeInQuint,
                      secondCurve: Curves.easeInQuint,
                      firstChild: childUnpressed,
                      secondChild: childPressed ?? childUnpressed,
                      crossFadeState: isPressed
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                    ),
                  ),
                ),
              ),
            ),
          ),
          btnText!.isNotEmpty
              ? ButtonText(btnText: btnText!)
              : const SizedBox(),
        ],
      ),
    );
  }
}