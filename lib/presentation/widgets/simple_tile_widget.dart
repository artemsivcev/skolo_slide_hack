import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/dimensions.dart';
import 'package:skolo_slide_hack/domain/constants/text_styles.dart';
import 'package:skolo_slide_hack/domain/models/tile.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/polymorphic_container.dart';

/// [SimpleTileWidget] stands for one tile widget.
/// Depending on the condition if tile is empty or not
/// need to show coloured container or empty sizedBox
class SimpleTileWidget extends StatefulWidget {
  SimpleTileWidget({
    Key? key,
    required this.tile,
    required this.onTap,
  }) : super(key: key);

  final Tile tile;
  final VoidCallback onTap;

  @override
  State<SimpleTileWidget> createState() => _SimpleTileWidgetState();
}

class _SimpleTileWidgetState extends State<SimpleTileWidget> {
  final _puzzleState = injector<PuzzleState>();

  //start animations
  late Animation<BorderRadius?> _borderRadiusAnimation;

  @override
  void initState() {
    super.initState();

    _borderRadiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(
        notInstalledTileCornerRadius,
      ),
      end: BorderRadius.circular(
        setTileCornerRadius,
      ),
    ).animate(
      CurvedAnimation(
        parent: _puzzleState.startAnimationController!,
        curve: Interval(
          _puzzleState.borderStartAnimatingBeginValue(widget.tile.value),
          _puzzleState.borderStartAnimatingEndValue(widget.tile.value),
          curve: Curves.bounceOut,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.tile.isEmpty
        ? const SizedBox()
        : InkWell(
            onTap: widget.onTap,
            child: AnimatedBuilder(
              animation: _puzzleState.startAnimationController!,
              builder: (_, __) {
                return PolymorphicContainer(
                  backgroundColor: Colors.indigoAccent,
                  userInnerStyle: false,
                  externalBorderRadius: _borderRadiusAnimation.value!,
                  child: Center(
                    child: Text(
                      '${widget.tile.value}',
                      style: numberTextStyle.copyWith(color: Colors.black),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
