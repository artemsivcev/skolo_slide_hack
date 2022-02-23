import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/entry_animation_state.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/entry/animated_breaking_glass.dart';

class EntryScreen extends StatefulWidget {
  final Widget child;

  const EntryScreen({Key? key, required this.child}) : super(key: key);

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen>
    with TickerProviderStateMixin {
  final entryAnimationState = injector<EntryAnimationState>();
  final menuState = injector<MenuState>();

  @override
  void initState() {
    super.initState();
    if (entryAnimationState.animationController == null) {
      entryAnimationState.initAnimation(this);
    }
    WidgetsBinding.instance!.addPostFrameCallback(
        (_) async => await entryAnimationState.createImage());
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        var isScreenImageNotNull = entryAnimationState.isScreenImageNotNull;

        return menuState.currentGameState == GameState.ENTRY
            ? Stack(
                children: [
                  // this is necessary for smooth animation transition
                  if (isScreenImageNotNull)
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.0,
                        child: Image(image: entryAnimationState.screenImage!),
                      ),
                    ),
                  Positioned.fill(
                    child: RepaintBoundary(
                      key: entryAnimationState.repaintBoundaryKey,
                      child: widget.child,
                    ),
                  ),
                ],
              )
            : AnimatedBuilder(
                animation: entryAnimationState.animationController!,
                builder: (context, child) => Stack(
                  children: entryAnimationState.partsScreen
                      .map(
                        (part) => Positioned.fill(
                          child: AnimatedBreakingGlass(
                            points: part,
                            progress: entryAnimationState.animation.value,
                            child: isScreenImageNotNull
                                ? Image(image: entryAnimationState.screenImage!)
                                : widget.child,
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
      },
    );
  }
}
