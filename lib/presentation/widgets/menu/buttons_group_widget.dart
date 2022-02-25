import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/adaptivity_solver/row_column_solver.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/buttons/button_glass.dart';

class ButtonsGroupWidget extends StatelessWidget {
  final menuState = injector<MenuState>();

  ButtonsGroupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RowColumnSolver(
      children: [
        Semantics(
          label: "Play with image",
          enabled: true,
          child: ButtonGlass(
            childUnpressed: SvgPicture.asset(
              'assets/images/puzzle-new-filled.svg',
              color: colorsPurpleBluePrimary,
            ),
            btnText: 'Play with image',
            onTap: () async {
              menuState.playWithImagePress();
            },
          ),
        ),
        Semantics(
          label: "Play without image",
          enabled: true,
          child: ButtonGlass(
            childUnpressed: const Icon(
              Icons.view_comfortable,
              size: 50.0,
              color: colorsPurpleBluePrimary,
            ),
            btnText: 'Play without image',
            onTap: () async {
              menuState.playWithOutImagePress();
            },
          ),
        ),
        !kIsWeb
            ? Observer(
                builder: (context) => Semantics(
                  label: "Exit the game",
                  enabled: true,
                  child: ButtonGlass(
                    childUnpressed: SvgPicture.asset(
                      'assets/images/exit.svg',
                      color: colorsPurpleBluePrimary,
                      height: 40,
                    ),
                    btnText: 'Exit',
                    isPressed: menuState.exitBtnPressed,
                    onTap: () {
                      menuState.toggleExitBtn(context);
                    },
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
