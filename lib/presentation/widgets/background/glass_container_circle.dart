import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';

class GlassContainerCircle extends StatelessWidget {
  const GlassContainerCircle({
    Key? key,
    required this.child,
    this.isHovered = false,
    this.padding,
    this.blurRadius,
  }) : super(key: key);

  final Widget child;
  final bool isHovered;
  final EdgeInsets? padding;
  final double? blurRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.8), width: 1.5),
        boxShadow: [
          isHovered
              ? BoxShadow(
                  color: colorsPurpleBluePrimary.withOpacity(0.7),
                  offset: const Offset(0, 0),
                  blurRadius: blurRadius ?? 18,
                  spreadRadius: 4)
              : const BoxShadow(color: Colors.transparent),
        ],
      ),
      child: child,
    );
  }
}
