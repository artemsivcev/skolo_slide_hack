import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/domain/states/difficulty_state.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';
import 'package:skolo_slide_hack/domain/states/shuffle_animation_state.dart';
import 'package:skolo_slide_hack/domain/states/start_animation_state.dart';
import 'package:skolo_slide_hack/domain/states/win_animation_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/simple_tile_widget.dart';

import 'movements_counter.dart';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> with TickerProviderStateMixin {
  final puzzleState = injector<PuzzleState>();
  final difficultyState = injector<DifficultyState>();
  final winAnimationState = injector<WinAnimationState>();
  final startAnimationState = injector<StartAnimationState>();
  final shuffleAnimationState = injector<ShuffleAnimationState>();

  @override
  void initState() {
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
        await Future.delayed(animationOneSecondDuration);
        startAnimationState.startAnimationController!.forward();
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    startAnimationState.isFirstScreenEntry = false;
    return Observer(
      builder: (context) {
        final showCorrectOrder = !startAnimationState.isStartAnimPart1End;

        var tiles =
            showCorrectOrder ? puzzleState.correctTiles : puzzleState.tiles;
        var isCompleted = puzzleState.isComplete;

        final startFlipAnimation = showCorrectOrder
            ? startAnimationState.flipAnimationPart1
            : startAnimationState.flipAnimationPart2;

        return Column(
          children: [
            const MovementsCounter(),
            AnimatedBuilder(
                animation: shuffleAnimationState.shakeAnimation!,
                child: AnimatedContainer(
                  width: isCompleted ? 338 : 310,
                  height: isCompleted ? 338 : 310,
                  duration: animationOneSecondDuration,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: PuzzleBoard(
                        size: difficultyState.boardSize,
                        spacing: 0,
                        tiles: List.generate(
                          tiles.length,
                          (index) => AnimatedBuilder(
                            animation: startFlipAnimation,
                            builder: (context, builderChild) {
                              return Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationX(
                                    startAnimationState.isStartAnimPart2End
                                        ? 0.0
                                        : startFlipAnimation.value!),
                                child: builderChild,
                              );
                            },
                            child: AnimatedPadding(
                              duration: animationOneSecondDuration,
                              padding: EdgeInsets.all(
                                  shuffleAnimationState.shuffled
                                      ? shuffleAnimationState
                                          .appearDisappearAnimation!.value!
                                      : startAnimationState
                                                  .startAnimationController!
                                                  .status ==
                                              AnimationStatus.completed
                                          ? winAnimationState.spacingValue
                                          : 0.0),
                              child: SimpleTileWidget(
                                tweenStart: index / tiles.length,
                                tween: winAnimationState.tweenForFlipping,
                                fadeAnimation: winAnimationState.fadeAnimation!,
                                isComplete: isCompleted &&
                                    winAnimationState.isAnimCompleted,
                                onTap: () => puzzleState.onTileTapped(index),
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
                      shuffleAnimationState.animationShuffleController!.value);
                  return Transform.translate(
                    // 4. apply a translation as a function of the animation value
                    offset: Offset(sineValue * 9, 0),
                    // 5. use the child widget
                    child: child,
                  );
                }),
          ],
        );
      },
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
    return Observer(builder: (_) {
      final isStartAnimationEnded = _startAnimation.isStartAnimPart2End;

      return AnimatedBuilder(
          animation: _startAnimation.startAnimationController!,
          builder: (_, __) {
            return GridView.count(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: size,
              mainAxisSpacing: isStartAnimationEnded
                  ? winAnimationState.spacingValue
                  : _startAnimation.puzzleBoardAxisPaddingAnimation.value!,
              crossAxisSpacing: isStartAnimationEnded
                  ? winAnimationState.spacingValue
                  : _startAnimation.puzzleBoardAxisPaddingAnimation.value!,
              children: tiles,
            );
          });
    });
  }
}