import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/glass_container_circle.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/column_row_solver.dart';

import 'button_text.dart';

class ButtonUnpressedCustom extends StatelessWidget {
  ButtonUnpressedCustom({
    Key? key,
    required this.child,
    this.btnText = "",
    required this.onTap,
    required this.isHovered,
    this.onHover,
  }) : super(key: key);

  ///Url for button icon
  final Widget child;

  ///Button text
  String? btnText = "";

  ///OnTap function
  final VoidCallback onTap;

  ///Checks if button is hovered
  final bool isHovered;

  ///OnHover function
  ValueChanged<bool>? onHover = (value) {};

  final menuState = injector<MenuState>();

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
            padding: const EdgeInsets.all(32.0),
            child: GlassContainerCircle(
              isHovered: isHovered,
              child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: Center(
                  child: AnimatedOpacity(
                    opacity: isHovered ? 1.0 : 0.7,
                    duration: const Duration(milliseconds: 170),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
          btnText!.isNotEmpty ? ButtonText(btnText: btnText!) : const SizedBox(),
        ],
      ),
    );
  }
}
