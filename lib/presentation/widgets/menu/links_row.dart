import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/screen_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/scolo_icon.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/small_skolo_icon.dart';
import 'github_icon.dart';

class LinksRow extends StatelessWidget {
  LinksRow({Key? key}) : super(key: key);

  final screenState = injector<ScreenState>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        var usedMobileVersion = screenState.usedMobileVersion;

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 13.0,
              ),
              child: Row(
                children: [
                  GitHubIcon(height: !usedMobileVersion ? 48 : 34),
                  // const SizedBox(width: 12),
                  // usedMobileVersion
                  //     ? const SmallSkoloIcon(height: 34)
                  //     : SkoloIcon(height: !usedMobileVersion ? 48 : 34),
                ],
              ),
            ),
            const SizedBox(width: 108),
          ],
        );
      },
    );
  }
}
