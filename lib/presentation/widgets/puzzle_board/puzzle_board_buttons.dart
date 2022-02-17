import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/buttons_hover_state.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';
import 'package:skolo_slide_hack/domain/states/shuffle_animation_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/buttons/button_glass.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/row_column_solver.dart';

class PuzzleBoardButtons extends StatelessWidget {
  final buttonsHoverState = injector<ButtonsHoverState>();
  final menuState = injector<MenuState>();
  final puzzleState = injector<PuzzleState>();
  final shuffleAnimationState = injector<ShuffleAnimationState>();

  PuzzleBoardButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return RowColumnSolver(
        children: [
          Semantics(
            label: "Go back to the menu",
            enabled: true,
            child: ButtonGlass(
              childUnpressed: const Icon(
                Icons.arrow_back,
                size: 50.0,
                color: colorsPurpleBluePrimary,
              ),
              btnText: 'Back',
              onTap: () async {
                menuState.backToMenu();
                buttonsHoverState.isBackHover = false;
              },
              isHovered: buttonsHoverState.isBackHover,
              onHover: (value) {
                buttonsHoverState.toggleBackHover();
              },
            ),
          ),
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
              // isPressed: puzzleState.shuffleBtnPressed,
              onTap: () async {
                shuffleAnimationState.shuffledPressed();
                shuffleAnimationState.animationShuffleController!.forward();
                await Future.delayed(const Duration(seconds: 1));
                await puzzleState.shuffleButtonTap();
              },
              isHovered: buttonsHoverState.shuffleBtnHovered,
              onHover: (value) => buttonsHoverState.toggleHoveredShuffleBtn(),
            ),
          ),
        ],
      );
    });
  }
}
