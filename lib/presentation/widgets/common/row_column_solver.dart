import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';

class RowColumnSolver extends StatefulWidget {
  const RowColumnSolver({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  _NewGameWidgetsOrientationSolver createState() =>
      _NewGameWidgetsOrientationSolver();
}

class _NewGameWidgetsOrientationSolver extends State<RowColumnSolver> {
  final menuState = injector<MenuState>();

  @override
  Widget build(BuildContext context) {
    return menuState.isPortrait(context)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:  CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: widget.children)
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: widget.children);
  }
}
