import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/domain/constants/text_styles.dart';
import 'package:skolo_slide_hack/domain/states/new_game_state.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';
import 'package:skolo_slide_hack/domain/states/win_animation_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/buttons/button_with_icon.dart';
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

  @override
  void initState() {
    //need to generate new puzzle with image
    puzzleState.generatePuzzle();
    var controller = AnimationController(
      duration: animationOneSecondDuration,
      vsync: this,
    );
    winAnimationState.initAnimation(controller);
    super.initState();
  }

  @override
  void dispose() {
    winAnimationState.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Observer(
            builder: (context) => Text(
              puzzleState.isComplete ? 'You win!!!!!!' : 'Find the solution',
              style: puzzlePageTitleTextStyle,
            ),
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWithIcon(
                color: blueColour,
                icon: const Icon(
                  Icons.refresh,
                ),
                onPressed: () => puzzleState.shuffleButtonTap(),
                iconColor: whiteColour,
              ),
              const SizedBox(width: 36),
              Observer(
                builder: (context) {
                  var tiles = puzzleState.tiles;
                  var isCompleted = puzzleState.isComplete;

                  return AnimatedContainer(
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
                                padding: EdgeInsets.all(
                                    winAnimationState.spacingValue),
                                child: SimpleTileWidget(
                                  tweenStart: index / tiles.length,
                                  tween: winAnimationState.tweenForFlipping,
                                  fadeAnimation:
                                      winAnimationState.fadeAnimation!,
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
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Displays the board of the puzzle.
class PuzzleBoard extends StatelessWidget {
  const PuzzleBoard({
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

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: size,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      children: tiles,
    );
  }
}
