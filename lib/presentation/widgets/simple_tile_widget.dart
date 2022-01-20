import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/constants/text_styles.dart';
import 'package:skolo_slide_hack/domain/models/tile.dart';

/// [SimpleTileWidget] stands for one tile widget.
/// Depending on the condition if tile is empty or not
/// need to show coloured container or empty sizedBox
class SimpleTileWidget extends StatelessWidget {
  const SimpleTileWidget({
    Key? key,
    required this.tile,
    required this.onTap,
  }) : super(key: key);

  final Tile tile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return tile.isEmpty
        ? const SizedBox()
        : InkWell(
            onTap: onTap,
            child: Container(
              color: blueColour,
              alignment: Alignment.center,
              child: Text(
                '${tile.value}',
                style: numberTextStyle,
              ),
            ),
          );
  }
}
