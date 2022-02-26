import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/domain/states/choose_image_state.dart';
import 'package:skolo_slide_hack/domain/states/menu_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/adaptivity_solver/row_column_solver.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/buttons/button_glass.dart';

class CropButtons extends StatefulWidget {
  const CropButtons({Key? key}) : super(key: key);

  @override
  _CropButtonsState createState() => _CropButtonsState();
}

class _CropButtonsState extends State<CropButtons>
    with TickerProviderStateMixin {
  final chooseImageState = injector<ChooseImageState>();
  final menuState = injector<MenuState>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return RowColumnSolver(
        children: [
          ButtonGlass(
            childUnpressed: const Icon(
              Icons.arrow_back,
              size: 50.0,
              color: colorsPurpleBluePrimary,
            ),
            btnText: 'back'.tr(),
            onTap: () async => menuState.backToMenu(),
          ),
          AnimatedCrossFade(
            crossFadeState: chooseImageState.chosenImage != null
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: animationTwoSecondsDuration,
            firstChild: Semantics(
              label: "Crop your image to square",
              enabled: true,
              child: ButtonGlass(
                childUnpressed: SvgPicture.asset(
                  'assets/images/puzzle-new.svg',
                  color: colorsPurpleBluePrimary,
                ),
                btnText: '${'crop'.tr()} & ${'play'.tr()}',
                onTap: () async {
                  await chooseImageState.splitImageAndPlay();
                },
              ),
            ),
            secondChild: const SizedBox(),
          ),
        ],
      );
    });
  }
}
