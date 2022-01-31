import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(55),
            border:
                Border.all(color: Colors.white.withOpacity(0.8), width: 1.5),
          ),
          child: child,
        ),
      ),
    );
  }
}
