import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/domain/constants/dimensions.dart';

/// Creates container stylized to the polymorphic style.
class PolymorphicContainer extends StatelessWidget {
  PolymorphicContainer({
    Key? key,
    required this.child,
    this.externalBorderRadius =
        const BorderRadius.all(Radius.circular(setTileCornerRadius)),
    this.innerShadowBorderRadius =
        const BorderRadius.all(Radius.circular(setTileCornerRadius)),
    this.darkShadowOffset = const Offset(7, 7),
    this.lightShadowOffset = const Offset(-7, -7),
    this.darkShadowBlurRadius = 7.0,
    this.lightShadowBlurRadius = 7.0,
    this.backgroundColor,
    this.userInnerStyle = false,
  }) : super(key: key);

  final Widget child;

  /// Corners radius of the external container.
  final BorderRadius externalBorderRadius;

  /// Corners radius of the inner shadows of the polymorphic container.
  final BorderRadius innerShadowBorderRadius;
  final Offset darkShadowOffset;
  final Offset lightShadowOffset;
  final double darkShadowBlurRadius;
  final double lightShadowBlurRadius;

  /// Main color on which based colors of the dark and light inner shadows.
  /// If it was not provided then the Theme.of(context).canvasColor used.
  final Color? backgroundColor;

  /// If true, then the container will have a "press in" effect.
  final bool userInnerStyle;

  Color _modifyBackGroundColor(
      Color backGroundColor, double lightnessModifier) {
    final hsl = HSLColor.fromColor(backGroundColor);
    final hslLight =
        hsl.withLightness((hsl.lightness + lightnessModifier).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  Color _getColorWithDarkTone(Color backGroundColor) {
    return _modifyBackGroundColor(backGroundColor, 0.3);
  }

  Color _getColorWithLightTone(Color backGroundColor) {
    return _modifyBackGroundColor(backGroundColor, -0.3).withOpacity(0.1);
  }

  @override
  Widget build(BuildContext context) {
    final defaultBackGroundColor =
        backgroundColor ?? Theme.of(context).canvasColor;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: externalBorderRadius,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: innerShadowBorderRadius,
          boxShadow: userInnerStyle
              ? [
                  BoxShadow(
                    blurRadius: darkShadowBlurRadius,
                    color: _getColorWithDarkTone(defaultBackGroundColor),
                    offset: darkShadowOffset,
                  ),
                  BoxShadow(
                    blurRadius: lightShadowBlurRadius,
                    color: _getColorWithLightTone(defaultBackGroundColor),
                    offset: lightShadowOffset,
                  ),
                ]
              : [
                  BoxShadow(
                    blurRadius: darkShadowBlurRadius,
                    color: _getColorWithLightTone(defaultBackGroundColor),
                    offset: darkShadowOffset,
                  ),
                  BoxShadow(
                    blurRadius: lightShadowBlurRadius,
                    color: _getColorWithDarkTone(defaultBackGroundColor),
                    offset: lightShadowOffset,
                  ),
                ],
        ),
        child: child,
      ),
    );
  }
}
