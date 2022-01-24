import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/buttons/button_with_icon.dart';
import 'package:skolo_slide_hack/presentation/widgets/simple_tile_widget.dart';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  final puzzleState = injector<PuzzleState>();

  Color getTopLightShadowColor(Color backGroundColor) {
    final hsl = HSLColor.fromColor(backGroundColor);
    final hslDark = hsl.withLightness((hsl.lightness - 0.3).clamp(0.0, 1.0));

    return hslDark.toColor().withOpacity(0.1);
  }

  Color getBottomDarkShadowColor(Color backGroundColor) {
    final hsl = HSLColor.fromColor(backGroundColor);
    final hslDark = hsl.withLightness((hsl.lightness + 0.3).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  @override
  Widget build(BuildContext context) {
    var bg_color = Theme.of(context).canvasColor;

    return Scaffold(
      body: Center(
        child: Row(
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
            Container(
              width: 307,
              height: 307,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7,
                      color: getBottomDarkShadowColor(bg_color),
                      offset: Offset(7, 7),
                    ),
                    BoxShadow(
                      blurRadius: 7,
                      color: getTopLightShadowColor(bg_color),
                      offset: Offset(-7, -7),
                    ),
                  ],
                ),
                child: Observer(
                  builder: (context) {
                    var tiles = puzzleState.tiles;

                    return Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: PuzzleBoard(
                          size: puzzleState.size,
                          tiles: List.generate(
                            tiles.length,
                            (index) => SimpleTileWidget(
                              onTap: () => puzzleState.onTileTapped(index),
                              tile: tiles[index],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
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
