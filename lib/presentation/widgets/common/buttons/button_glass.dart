import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/adaptivity_solver/column_row_solver.dart';

import 'button_text.dart';

class ButtonGlass extends StatelessWidget {
  ButtonGlass({
    Key? key,
    required this.childUnpressed,
    this.childPressed,
    this.isPressed = false,
    this.btnText = "",
    this.onTap,
    required this.isHovered,
    this.size = 70,
    this.onHover,
    this.padding,
    this.isDisabled,
  }) : super(
          key: key,
        );

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

  ///Checks if button is hovered
  final bool isHovered;

  ///OnHover function
  ValueChanged<bool>? onHover = (value) {};

  ///btn custom size
  final double size;

  ///btn custom padding
  EdgeInsetsGeometry? padding = const EdgeInsets.all(20.0);

  final bool? isDisabled;

  @override
  Widget build(BuildContext context) {
    return ColumnRowSolver(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: HoverContainer(
            isDisabled: isDisabled ?? false,
            child: ElevatedButton(
              onPressed: onTap,
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size?>(
                  Size(size, size),
                ),
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered) ||
                        states.contains(
                          MaterialState.disabled,
                        )) {
                      return Colors.white.withOpacity(0.6);
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

class HoverContainer extends StatefulWidget {
  HoverContainer({
    Key? key,
    required this.child,
    required this.isDisabled,
  }) : super(key: key);

  final Widget child;
  bool isDisabled;

  @override
  State<HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<HoverContainer> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          if (!widget.isDisabled) {
            isHovered = true;
          }
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            isHovered
                ? BoxShadow(
                    color: colorsPurpleBluePrimary.withOpacity(0.7),
                    offset: const Offset(0, 0),
                    blurRadius: 18,
                    spreadRadius: 4,
                  )
                : const BoxShadow(color: Colors.transparent),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
