import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/domain/models/triangle.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';

part 'entry_animation_state.g.dart';

class EntryAnimationState = _EntryAnimationState with _$EntryAnimationState;

/// State is used for showing entry animation when the user starts the game.
abstract class _EntryAnimationState with Store {
  /// screen transformed to the image for making animation
  @observable
  MemoryImage? screenImage;

  /// parts of screen (coordinates of triangles angels)
  @observable
  ObservableList<List<Offset>> partsScreen = ObservableList.of([]);

  /// Animation controller for entry animation.
  AnimationController? animationController;

  late Animation<double> animation;

  /// tween for breaking glass
  final Tween<double> tween = Tween(begin: 0.0, end: 1.0);

  /// Define a key for screen repainting boundary
  final repaintBoundaryKey = GlobalKey(debugLabel: 'repaintBoundaryKey');

  @computed
  bool get isScreenImageNotNull => screenImage != null;

  /// init the controller and animations
  @action
  initAnimation(TickerProvider tickerProvider) {
    animationController = AnimationController(
      vsync: tickerProvider,
      duration: animationOneSecondDuration,
    )..addListener(() {});

    animation = tween.animate(
      CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInSine),
      ),
    );
  }

  /// create [screenImage], that is necessary for smooth animation
  /// transition, when breaking glass
  @action
  Future<void> createImage() async {
    try {
      final boundary = repaintBoundaryKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary;
      final image = await boundary.toImage();
      final byteData = await (image.toByteData(format: ImageByteFormat.png)
          as FutureOr<ByteData>);
      final pngBytes = byteData.buffer.asUint8List();
      screenImage = MemoryImage(pngBytes);
    } catch (_) {
      screenImage = null;
    }
    partsScreen = ObservableList.of(generateParts());
  }

  /// generate new parts from triangles.
  /// Argument `repeats` stands for how many times the process of
  /// dividing must be repeated. It influences the complexity of the
  /// algorithm and the amount of new triangles.
  /// The algorithm starts with these two triangles,
  /// which are created with the diagonal the separates screen
  Iterable<List<Offset>> generateParts({int repeats = 2}) {
    var triangles = [
      Triangle(const Offset(0, 0), const Offset(0, 1), const Offset(1, 0)),
      Triangle(const Offset(1, 1), const Offset(0, 1), const Offset(1, 0)),
    ];

    for (int r = 0; r < repeats; r++) {
      triangles = triangles.expand((t) => t.divide()).toList();
    }
    return triangles.map((t) => t.props);
  }

  /// start animation
  @action
  void startBreakingGlass() {
    animationController!.forward();
    injector<MenuState>().changeCurrentGameState(GameState.MAIN_MENU);
  }

  /// reset animation
  @action
  void resetStartAnimation() {
    animationController?.reset();
  }

  void dispose() {
    animationController?.dispose();
  }
}
