import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/scolo_icon.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/small_skolo_icon.dart';

import 'dash_icon.dart';
import 'github_icon.dart';

class LinksRow extends StatelessWidget {
  const LinksRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Builder(builder: (_) {

          final screenSize = MediaQuery.of(context).size;

          final isWebMobile = kIsWeb &&
              (defaultTargetPlatform == TargetPlatform.iOS ||
                  defaultTargetPlatform == TargetPlatform.android);

          //rotate if a screen width < screen height. only for mobile devices
          final rotationQuarter = kIsWeb
              ? screenSize.width < screenSize.height || isWebMobile
                  ? 1
                  : 0
              : screenSize.width > screenSize.height
                  ? 1
                  : 0;

          final usedSmallMobileVersion = rotationQuarter == 1;

          return Padding(
            padding: const EdgeInsets.only(
              bottom:16.0,
            ),
            child: Row(
                    children: [
                      const GitHubIcon(),
                      const SizedBox(width: 12),
                      usedSmallMobileVersion
                          ? const SmallSkoloIcon()
                          : const SkoloIcon(),
                    ],
                  ),
          );
        }),
        DashIcon(),
      ],
    );
  }
}
