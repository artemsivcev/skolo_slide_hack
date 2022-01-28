import 'package:flutter/material.dart';

class NewGameWidgetsOrientationSolver extends StatefulWidget {
  const NewGameWidgetsOrientationSolver({Key? key, required this.children})
      : super(key: key);

  final List<Widget> children;

  @override
  _NewGameWidgetsOrientationSolver createState() =>
      _NewGameWidgetsOrientationSolver();
}

class _NewGameWidgetsOrientationSolver
    extends State<NewGameWidgetsOrientationSolver> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: widget.children)
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: widget.children);
  }
}
