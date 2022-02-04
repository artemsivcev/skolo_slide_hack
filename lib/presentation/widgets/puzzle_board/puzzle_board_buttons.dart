import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';
import 'package:skolo_slide_hack/domain/states/shuffle_animation_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/buttons/button_glass.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/row_column_solver.dart';

class PuzzleBoardButtons extends StatelessWidget {
  final puzzleState = injector<PuzzleState>();
  final shuffleAnimationState = injector<ShuffleAnimationState>();

  PuzzleBoardButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return RowColumnSolver(
        children: [
          Semantics(
            label: "Shuffle puzzle boarder",
            enabled: true,
            child: ButtonGlass(
              childUnpressed: SvgPicture.asset(
                'assets/images/restart.svg',
                color: colorsPurpleBluePrimary,
                height: 40,
              ),
              btnText: 'Shuffle',
              isPressed: puzzleState.shuffleBtnPressed,
              onTap: () async {
                shuffleAnimationState.shuffledPressed();
                shuffleAnimationState.animationShuffleController!.forward();
                await Future.delayed(const Duration(seconds: 1));

                await puzzleState.shuffleButtonTap();
              },
              isHovered: puzzleState.shuffleBtnHovered,
              onHover: (value) => puzzleState.toggleHoveredShuffleBtn(),
            ),
          ),
        ],
      );
    });
  }
}
