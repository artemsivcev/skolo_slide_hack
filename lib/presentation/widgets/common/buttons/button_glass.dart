import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/adaptivity_solver/column_row_solver.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/buttons/hovered_container.dart';

import 'button_text.dart';

class ButtonGlass extends StatelessWidget {
  ButtonGlass({
    Key? key,
    required this.childUnpressed,
    this.childPressed,
    this.isPressed = false,
    this.btnText = "",
    this.onTap,
    this.size = 50,
    this.padding = const EdgeInsets.all(20.0),
    this.isDisabled = false,
    this.extraSpace = 32,
  }) : super(key: key);

  ///Widget for unpressed button
  final Widget childUnpressed;

  ///Widget for pressed button
  Widget? childPressed;

  ///Is button pressed
  bool isPressed = false;

  ///Button text
  String? btnText = "";

  ///OnTap function
  final VoidCallback? onTap;

  ///btn custom size
  final double size;

  /// add extra space as padding for inner button
  final double extraSpace;

  ///btn custom padding
  EdgeInsetsGeometry padding;

  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return ColumnRowSolver(
      children: [
        Padding(
          padding: padding,
          child: HoverContainer(
            isDisabled: isDisabled,
            child: ElevatedButton(
              onPressed: onTap,
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size?>(
                  Size(size + extraSpace, size + extraSpace),
                ),
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered) ||
                        states.contains(
                          MaterialState.disabled,
                        ) ||
                        isDisabled) {
                      return Colors.white.withOpacity(0.4);
                    }

                    return Colors.white.withOpacity(0.4);
                  },
                ),
                foregroundColor: MaterialStateProperty.all<Color?>(
                  Colors.transparent,
                ),
                overlayColor: MaterialStateProperty.all<Color?>(
                  Colors.transparent,
                ),
                shadowColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered) ||
                        states.contains(
                          MaterialState.disabled,
                        )) {
                      return colorsPurpleBluePrimary.withOpacity(0.1);
                    }

                    return Colors.transparent;
                  },
                ),
                shape: MaterialStateProperty.all<OutlinedBorder?>(
                  CircleBorder(
                    side: BorderSide(
                      color: Colors.white.withOpacity(0.8),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              child: Center(
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
        btnText!.isNotEmpty
            ? ButtonText(
                btnText: btnText!,
              )
            : const SizedBox(),
      ],
    );
  }
}
