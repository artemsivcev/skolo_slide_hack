import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';

class ColumnRowSolver extends StatefulWidget {
  const ColumnRowSolver({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  _NewGameWidgetsOrientationSolver createState() =>
      _NewGameWidgetsOrientationSolver();
}

class _NewGameWidgetsOrientationSolver extends State<ColumnRowSolver> {
  final menuState = injector<MenuState>();

  @override
  Widget build(BuildContext context) {
    return menuState.isPortrait(context)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: widget.children)
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: widget.children);
  }
}
