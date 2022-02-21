import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/buttons_hover_state.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';
import 'package:skolo_slide_hack/domain/states/screen_state.dart';
import 'package:skolo_slide_hack/domain/states/shuffle_animation_state.dart';
import 'package:skolo_slide_hack/domain/states/tile_animation_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/buttons/button_glass.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/adaptivity_solver/row_column_solver.dart';

class PuzzleBoardButtons extends StatelessWidget {
  final buttonsHoverState = injector<ButtonsHoverState>();
  final menuState = injector<MenuState>();
  final puzzleState = injector<PuzzleState>();
  final shuffleAnimationState = injector<ShuffleAnimationState>();
  final screenState = injector<ScreenState>();
  final animatedTileState = injector<TileAnimationState>();

  PuzzleBoardButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      var usedMobileVersion = screenState.usedMobileVersion;
      var isButtonActive =
          animatedTileState.currentAnimationPhase == TileAnimationPhase.NORMAL;

      return RowColumnSolver(
        children: [
          Semantics(
            label: "Go back to the menu",
            enabled: true,
            child: ButtonGlass(
              childUnpressed: Icon(
                Icons.arrow_back,
                size: usedMobileVersion ? 32 : 44,
                color: colorsPurpleBluePrimary,
              ),
              btnText: 'Back',
              onTap: () async {
                menuState.backToMenu();
                buttonsHoverState.isBackHover = false;
              },
              size: usedMobileVersion ? 30 : 44,
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
                color: isButtonActive
                    ? colorsPurpleBluePrimary
                    : colorsPurpleBluePrimaryLight,
                height: usedMobileVersion ? 26 : 34,
              ),
              btnText: 'Shuffle',
              size: usedMobileVersion ? 30 : 44,
              onTap: isButtonActive
                  ? () async {
                      shuffleAnimationState.shuffledPressed();
                      shuffleAnimationState.animationController!.forward();
                      await puzzleState.shuffleButtonTap();
                    }
                  : () {},
              isHovered: buttonsHoverState.shuffleBtnHovered,
              isDisabled: !isButtonActive,
              onHover: (value) => buttonsHoverState.toggleHoveredShuffleBtn(),
            ),
          ),
        ],
      );
    });
  }
}
