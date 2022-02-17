import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/screen_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/scolo_icon.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/small_skolo_icon.dart';

import 'dash_icon.dart';
import 'github_icon.dart';

class LinksRow extends StatelessWidget {
  LinksRow({Key? key}) : super(key: key);

  final screenState = injector<ScreenState>();

  @override
  Widget build(BuildContext context) {
    final isWebMobile = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);

    //rotate if a screen width < screen height. only for mobile devices
    final usedMobileVersion = kIsWeb && !isWebMobile
        ? screenState.screenWidth < screenState.screenHeight
        : true;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 20.0,
          ),
          child: Row(
            children: [
              GitHubIcon(height: !usedMobileVersion ? 48 : 36),
              const SizedBox(width: 12),
              usedMobileVersion
                  ? const SmallSkoloIcon(height: 36)
                  : SkoloIcon(height: !usedMobileVersion ? 48 : 36),
            ],
          ),
        ),
        DashIcon(),
      ],
    );
  }
}
