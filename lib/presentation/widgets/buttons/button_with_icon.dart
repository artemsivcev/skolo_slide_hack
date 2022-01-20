import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({
    Key? key,
    this.onPressed,
    required this.icon,
    this.color,
    this.iconColor,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget icon;
  final Color? color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 30,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: iconColor,
        hoverColor: Colors.transparent,
      ),
    );
  }
}
