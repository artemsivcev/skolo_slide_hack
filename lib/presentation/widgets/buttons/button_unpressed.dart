import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/column_row_solver.dart';

import 'button_text.dart';

class ButtonUnpressed extends StatelessWidget {
  ButtonUnpressed({
    Key? key,
    required this.iconUrl,
    required this.btnText,
    required this.onTap,
    required this.isHovered,
    required this.onHover,
  }) : super(key: key);

  ///Url for button icon
  final String iconUrl;

  ///Button text
  final String btnText;

  ///OnTap function
  final VoidCallback onTap;

  ///Checks if button is hovered
  final bool isHovered;

  ///OnHover function
  final ValueChanged<bool> onHover;

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
            child: Container(
              height: 100.0,
              width: 100.0,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: AnimatedOpacity(
                  opacity: isHovered ? 1.0 : 0.7,
                  duration: const Duration(milliseconds: 170),
                  child: SvgPicture.asset(
                    iconUrl,
                    color: colorsPurpleBluePrimary,
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                color: colorsGreyMediumPrimary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: colorsWhitePrimary,
                      offset: Offset(-10, -10),
                      blurRadius: 20,
                      spreadRadius: 0),
                  BoxShadow(
                      color: colorsGreyDarkPrimary,
                      offset: Offset(10, 10),
                      blurRadius: 20,
                      spreadRadius: 0)
                ],
              ),
            ),
          ),
          ButtonText(btnText: btnText),
        ],
      ),
    );
  }
}
