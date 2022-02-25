import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    Key? key,
    required this.child,
    this.innerPadding,
    this.color,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets? innerPadding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Container(
          padding: innerPadding ?? const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: color ?? Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
            border:
                Border.all(color: Colors.white.withOpacity(0.8), width: 1.5),
          ),
          child: child,
        ),
      ),
    );
  }
}
