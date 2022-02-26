import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';

class HoverContainer extends StatefulWidget {
  const HoverContainer({
    Key? key,
    required this.child,
    required this.isDisabled,
  }) : super(key: key);

  final Widget child;
  final bool isDisabled;

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
