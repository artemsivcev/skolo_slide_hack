import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/domain/states/difficulty_state.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';
import 'package:skolo_slide_hack/domain/states/screen_state.dart';
import 'package:skolo_slide_hack/domain/states/shuffle_animation_state.dart';
import 'package:skolo_slide_hack/domain/states/start_animation_state.dart';
import 'package:skolo_slide_hack/domain/states/tile_animation_state.dart';
import 'package:skolo_slide_hack/domain/states/win_animation_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/board_animations/board_shuffle_animator.dart';
import 'package:skolo_slide_hack/presentation/widgets/puzzle_board/game_timer.dart';
import 'package:skolo_slide_hack/presentation/widgets/puzzle_board/movements_counter.dart';
import 'package:skolo_slide_hack/presentation/widgets/tiles_animations/animated_tile.dart';

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
  final screenState = injector<ScreenState>();

  @override
  void initState() {
    var controller = AnimationController(
      duration: animationOneSecondDuration,
      vsync: this,
    );
    winAnimationState.initAnimation(controller);

    if (startAnimationState.animationController == null) {
      startAnimationState.initStartAnimationController(this);
    }

    startAnimationState.startAnimation();

    var controllerShuffle = AnimationController(
      duration: animationOneSecondDuration,
      vsync: this,
    );
    shuffleAnimationState.initAnimation(controllerShuffle);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        var usedMobileVersion = screenState.usedMobileVersion;

        double biggerSize = usedMobileVersion ? 310 : 350;
        double smallerSize = usedMobileVersion ? 280 : 320;

        return Column(
          children: [
            const MovementsCounter(),
            PuzzleBoard(
              smallerSize: smallerSize,
              biggerSize: biggerSize,
              size: difficultyState.boardSize,
            ),
            GameTimer(),
          ],
        );

        // final showCorrectOrder = !startAnimationState.isStartAnimPart1End;
        //
        // // var tiles =
        // //     showCorrectOrder ? puzzleState.correctTiles : puzzleState.tiles;
        // var isCompleted = puzzleState.isComplete;
        //
        // final startFlipAnimation = showCorrectOrder
        //     ? startAnimationState.flipAnimationPart1
        //     : startAnimationState.flipAnimationPart2;
        //
        // return AnimatedBuilder(
        //         animation: shuffleAnimationState.shakeAnimation!,
        //         child: AnimatedContainer(
        //           width: isCompleted ? biggerSize : smallerSize,
        //           height: isCompleted ? biggerSize : smallerSize,
        //           duration: animationOneSecondDuration,
        //           child: Padding(
        //             padding: const EdgeInsets.all(10),
        //             child: SizedBox(
        //               width: smallerSize,
        //               height: smallerSize,
        //               child: PuzzleBoard(
        //                 size: difficultyState.boardSize,
        //                 spacing: 0,
        //                 tiles: List.generate(
        //                   tiles.length,
        //                   (index) => AnimatedBuilder(
        //                     animation: startFlipAnimation,
        //                     builder: (context, builderChild) {
        //                       return Transform(
        //                         alignment: Alignment.center,
        //                         transform: Matrix4.rotationX(
        //                             startAnimationState.isStartAnimPart2End
        //                                 ? 0.0
        //                                 : startFlipAnimation.value!),
        //                         child: builderChild,
        //                       );
        //                     },
        //                     child: AnimatedPadding(
        //                       duration: animationOneSecondDuration,
        //                       padding: EdgeInsets.all(
        //                           shuffleAnimationState.shuffled
        //                               ? shuffleAnimationState
        //                                   .appearDisappearAnimation!.value!
        //                               : startAnimationState
        //                                           .startAnimationController!
        //                                           .status ==
        //                                       AnimationStatus.completed
        //                                   ? winAnimationState.spacingValue
        //                                   : 0.0),
        //                       child: SimpleTileWidget(
        //                         tweenStart: index / tiles.length,
        //                         tween: winAnimationState.tweenForFlipping,
        //                         fadeAnimation: winAnimationState.fadeAnimation!,
        //                         isComplete: isCompleted &&
        //                             winAnimationState.isAnimCompleted,
        //                         onTap: () => puzzleState.onTileTapped(index),
        //                         tile: tiles[index],
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //         builder: (context, child) {
        //           final sineValue = sin(3 *
        //               2 *
        //               pi *
        //               shuffleAnimationState.animationController!.value);
        //           return Transform.translate(
        //             // 4. apply a translation as a function of the animation value
        //             offset: Offset(sineValue * 9, 0),
        //             // 5. use the child widget
        //             child: child,
        //           );
        //         });
      },
    );
  }
}

/// Displays the board of the puzzle.
class PuzzleBoard extends StatelessWidget {
  PuzzleBoard({
    Key? key,
    required this.size,
    this.spacing = 8,
    required this.biggerSize,
    required this.smallerSize,
  }) : super(key: key);

  /// height and width of the board
  final double biggerSize;

  final double smallerSize;

  /// The dimension of the board.
  final int size;

  /// The spacing between each tile from [tiles].
  final double spacing;

  final _startAnimation = injector<StartAnimationState>();
  final _winAnimationState = injector<WinAnimationState>();
  final _animatedTileState = injector<TileAnimationState>();
  final _puzzleState = injector<PuzzleState>();
  final _shuffleAnimationState = injector<ShuffleAnimationState>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        /// The tiles to be displayed on the board.
        var tiles = _puzzleState.tiles;

        final animationPhase = _animatedTileState.currentAnimationPhase;

        final isCompleted = _puzzleState.isComplete;

        if (animationPhase == null) {
          return const SizedBox();
        }

        double? usedAnimationValue;

        final AnimationController? animationController;

        if (animationPhase == TileAnimationPhase.START_ANIMATION) {
          usedAnimationValue =
              _startAnimation.puzzleBoardAxisPaddingAnimation.value;
          tiles = _puzzleState.correctTiles;
          animationController = _startAnimation.animationController;
        } else {
          usedAnimationValue = _winAnimationState.spacingValue;
          tiles = _puzzleState.tiles;
          animationController = _shuffleAnimationState.animationController;
        }

        final tilesList = List.generate(
          tiles.length,
          (index) => AnimatedTile(
            tile: tiles[index],
            fraction: index / tiles.length,
            onTap: () => _puzzleState.onTileTapped(index),
          ),
        );

        return AnimatedBuilder(
          animation: animationController!,
          builder: (_, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 900),
              curve: Curves.fastOutSlowIn,
              height: isCompleted ? biggerSize : smallerSize,
              width: isCompleted ? biggerSize : smallerSize,
              padding: const EdgeInsets.all(10),
              child: BoardShuffleAnimator(
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  crossAxisCount: size,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: usedAnimationValue!,
                  crossAxisSpacing: usedAnimationValue,
                  children: tilesList,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
