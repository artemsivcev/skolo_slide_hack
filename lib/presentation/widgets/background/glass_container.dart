import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    Key? key,
    required this.child,
    this.width = 250,
  }) : super(key: key);

  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(55),
          border: Border.all(color: Colors.white.withOpacity(0.8), width: 1.5),
        ),
        child: child,
      ),
    );
  }
}
