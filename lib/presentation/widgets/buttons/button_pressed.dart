import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/column_row_solver.dart';

import 'button_inner_highlight.dart';
import 'button_inner_shadow.dart';
import 'button_text.dart';

class ButtonPressed extends StatelessWidget {
  ButtonPressed({
    Key? key,
    required this.iconUrl,
    required this.btnText,
    required this.onTap,
  }) : super(key: key);

  ///Url for button icon
  final String iconUrl;

  ///Button text
  final String btnText;

  ///OnTap function
  final VoidCallback onTap;

  final menuState = injector<MenuState>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: ColumnRowSolver(
        children: [
          Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: colorsGreyMediumPrimary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: colorsWhitePrimary,
                            offset: Offset(-10, -10),
                            blurRadius: 20,
                            spreadRadius: 0),
                      ],
                    ),
                  ),
                ),
                ClipPath(
                  clipper: ShadowClipper(),
                  child: const ButtonCircleInnerShadow(
                    shadowColor: colorsGreyDarkPrimary,
                    backgroundColor: colorsGreyMediumPrimary,
                  ),
                ),
                ClipPath(
                    clipper: HighlightClipper(),
                    child: const ButtonCircleInnerHighlight(
                      highlightColor: colorsGreyLightPrimary,
                      backgroundColor: colorsGreyMediumPrimary,
                    )),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: SvgPicture.asset(
                      iconUrl,
                      color: colorsPurpleBluePrimary,
                    ),
                  ),
                ),
              ]),
          ButtonText(btnText: btnText),
        ],
      ),
    );
  }
}
