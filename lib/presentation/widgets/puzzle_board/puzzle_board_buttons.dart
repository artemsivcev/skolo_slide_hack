import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/domain/states/screen_state.dart';
import 'package:skolo_slide_hack/domain/states/shuffle_animation_state.dart';
import 'package:skolo_slide_hack/domain/states/tile_animation_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/adaptivity_solver/row_column_solver.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/buttons/button_glass.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/buttons/rotated_shuffle_button.dart';

class PuzzleBoardButtons extends StatelessWidget {
  final menuState = injector<MenuState>();

  final shuffleAnimationState = injector<ShuffleAnimationState>();
  final screenState = injector<ScreenState>();
  final animatedTileState = injector<TileAnimationState>();

  PuzzleBoardButtons({Key? key}) : super(key: key);
// todo size
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
              btnText: 'back'.tr(),
              onTap: () async {
                menuState.backToMenu();
              },
              size: usedMobileVersion ? 30 : 44,
            ),
          ),
          //Shuffle
          Semantics(
            label: "Shuffle puzzle board",
            enabled: true,
            child: ButtonGlass(
              btnText: 'shuffle'.tr(),
              size: usedMobileVersion ? 30 : 44,
              childUnpressed: RotatedShuffleButton(
                isButtonActive: isButtonActive,
                buttonSize: usedMobileVersion ? 30 : 44,
              ),
              onTap: () {},
              isDisabled: !isButtonActive,
            ),
          ),
        ],
      );
    });
  }
}
