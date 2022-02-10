import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu/scolo_icon.dart';

import 'dash_icon.dart';
import 'github_icon.dart';

class LinksRow extends StatelessWidget {
  const LinksRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 16.0,
            ),
            child: Row(
              children: const [
                const GitHubIcon(),
                const SizedBox(width: 12),
                const SkoloIcon(),
              ],
            ),
          ),
          DashIcon(),
        ],
      ),
    );
  }
}
