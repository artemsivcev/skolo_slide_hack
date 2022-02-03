import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';

class GlassContainerCircle extends StatelessWidget {
  const GlassContainerCircle({
    Key? key,
    required this.child,
    this.isHovered = false,
  }) : super(key: key);

  final Widget child;
  final bool isHovered;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.8), width: 1.5),
        boxShadow: [
          const BoxShadow(
              color: colorsWhitePrimary,
              offset: Offset(-10, -10),
              blurRadius: 20,
              spreadRadius: 0),
          const BoxShadow(
              color: colorsGreyDarkPrimary,
              offset: Offset(10, 10),
              blurRadius: 20,
              spreadRadius: 0),
          isHovered
              ? BoxShadow(
                  color: colorsPurpleBluePrimary.withOpacity(0.7),
                  offset: const Offset(0, 0),
                  blurRadius: 20,
                  spreadRadius: 5)
              : const BoxShadow(color: Colors.transparent),
        ],
      ),
      child: child,
    );
  }
}
