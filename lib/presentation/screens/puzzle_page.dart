import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/domain/states/new_game_state.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';
import 'package:skolo_slide_hack/domain/states/shuffle_animation_state.dart';
import 'package:skolo_slide_hack/domain/states/start_animation_state.dart';
import 'package:skolo_slide_hack/domain/states/win_animation_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/polymorphic_container.dart';
import 'package:skolo_slide_hack/presentation/widgets/simple_tile_widget.dart';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> with TickerProviderStateMixin {
  final puzzleState = injector<PuzzleState>();
  final newGameState = injector<NewGameState>();
  final winAnimationState = injector<WinAnimationState>();
  final startAnimationState = injector<StartAnimationState>();
  final shuffleAnimationState = injector<ShuffleAnimationState>();

  @override
  void initState() {
    //need to generate new puzzle with image
    puzzleState.generatePuzzle();
    var controller = AnimationController(
      duration: animationOneSecondDuration,
      vsync: this,
    );
    winAnimationState.initAnimation(controller);
    startAnimationState.initStartAnimationController(this);

    var controllerShuffle = AnimationController(
      duration: animationOneSecondDuration,
      vsync: this,
    );
    shuffleAnimationState.initAnimation(controllerShuffle);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    reaction<bool>((_) => startAnimationState.isFirstScreenEntry,
        (value) async {
      if (!value) {
        await Future.delayed(const Duration(seconds: 1));
        startAnimationState.startAnimationController!.forward();
      }
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    winAnimationState.disposeControllers();
    shuffleAnimationState.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    startAnimationState.isFirstScreenEntry = false;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Observer(
        //   builder: (context) => Text(
        //     puzzleState.isComplete ? 'You win!!!!!!' : 'Find the solution',
        //     style: puzzlePageTitleTextStyle,
        //   ),
        // ),
        // const SizedBox(height: 36),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Observer(
              builder: (context) {
                var tiles = puzzleState.tiles;
                var isCompleted = puzzleState.isComplete;

                return AnimatedBuilder(
                    animation: shuffleAnimationState.offsetAnimation!,
                    child: AnimatedContainer(
                      width: isCompleted ? 340 : 310,
                      height: isCompleted ? 340 : 310,
                      duration: animationOneSecondDuration,
                      child: PolymorphicContainer(
                        userInnerStyle: true,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            width: 300,
                            height: 300,
                            child: PuzzleBoard(
                              size: newGameState.boardSize,
                              spacing: 0,
                              tiles: List.generate(
                                tiles.length,
                                (index) => AnimatedPadding(
                                  duration: animationOneSecondDuration,
                                  padding: EdgeInsets.all(isCompleted
                                      ? winAnimationState.spacingValue
                                      : startAnimationState
                                                  .startAnimationController!
                                                  .status ==
                                              AnimationStatus.completed
                                          ? winAnimationState.spacingValue
                                          : 0.0),
                                  child: SimpleTileWidget(
                                    tweenStart: index / tiles.length,
                                    tween: winAnimationState.tweenForFlipping,
                                    fadeAnimation:
                                        winAnimationState.fadeAnimation!,
                                    isComplete: isCompleted &&
                                        winAnimationState.isAnimCompleted,
                                    onTap: () =>
                                        puzzleState.onTileTapped(index),
                                    tile: tiles[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    builder: (context, child) {
                      final sineValue = sin(3 *
                          2 *
                          pi *
                          shuffleAnimationState
                              .animationShuffleController!.value);
                      return Transform.translate(
                        // 4. apply a translation as a function of the animation value
                        offset: Offset(sineValue * 9, 0),
                        // 5. use the child widget
                        child: child,
                      );
                    });
              },
            ),
          ],
        ),
      ],
    );
  }
}

/// Displays the board of the puzzle.
class PuzzleBoard extends StatelessWidget {
  PuzzleBoard({
    Key? key,
    required this.size,
    required this.tiles,
    this.spacing = 8,
  }) : super(key: key);

  /// The size of the board.
  final int size;

  /// The tiles to be displayed on the board.
  final List<Widget> tiles;

  /// The spacing between each tile from [tiles].
  final double spacing;

  final _startAnimation = injector<StartAnimationState>();
  final winAnimationState = injector<WinAnimationState>();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _startAnimation.startAnimationController!,
        builder: (_, __) {
          return GridView.count(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: size,
            mainAxisSpacing: _startAnimation.startAnimationController!.status ==
                    AnimationStatus.completed
                ? winAnimationState.spacingValue
                : _startAnimation.puzzleBoardAxisPaddingAnimation.value!,
            crossAxisSpacing:
                _startAnimation.startAnimationController!.status ==
                        AnimationStatus.completed
                    ? winAnimationState.spacingValue
                    : _startAnimation.puzzleBoardAxisPaddingAnimation.value!,
            children: tiles,
          );
        });
  }
}
