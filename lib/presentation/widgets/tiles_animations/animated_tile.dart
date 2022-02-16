import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/models/tile.dart';
import 'package:skolo_slide_hack/domain/states/start_animation_state.dart';
import 'package:skolo_slide_hack/domain/states/tile_animation_state.dart';
import 'package:skolo_slide_hack/domain/states/win_animation_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/polymorphic_container_pure.dart';
import 'package:skolo_slide_hack/presentation/widgets/tiles_animations/tile_start_play_animator.dart';
import 'package:skolo_slide_hack/presentation/widgets/tiles_animations/tile_win_animator.dart';

class AnimatedTile extends StatelessWidget {
  AnimatedTile({
    Key? key,
    required this.tile,
    required this.onTap,
    required this.fraction,
  }) : super(key: key);

  final Tile tile;

  final VoidCallback onTap;

  final double fraction;

  final TileAnimationState _animatedTileState = injector<TileAnimationState>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        final animationPhase = _animatedTileState.currentAnimationPhase;

        if (animationPhase == null) {
          return SizedBox();
        }

        final AnimationController? animationController;
        switch (animationPhase) {
          case TileAnimationPhase.WIN:
            animationController =
                injector<WinAnimationState>().animationController;
            break;

          /// for TileAnimationPhase.START_ANIMATION
          default:
            animationController =
                injector<StartAnimationState>().startAnimationController;
        }

        return AnimatedBuilder(
          animation: animationController!,
          builder: (_, child) {
            if (animationPhase == TileAnimationPhase.START_ANIMATION) {
              return tile.isEmpty
                  ? const SizedBox()
                  : TileStartAnimator(child: child!);
            }

            if (animationPhase == TileAnimationPhase.WIN) {
              return TileWinAnimator(
                child: child!,
                tweenStart: fraction,
                tile: tile,
              );
            }

            // for TileAnimationPhase.NORMAL
            return tile.isEmpty
                ? const SizedBox()
                : PolymorphicContainerPure(child: child!);
          },
          child: TileToShow(
            tile: tile,
            onTap: onTap,
          ),
        );
      },
    );
  }
}

class TileToShow extends StatelessWidget {
  const TileToShow({
    Key? key,
    required this.tile,
    required this.onTap,
  }) : super(key: key);

  final Tile tile;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tileWidget = tile.customImage == null
        ? TextTileContent(
            title: tile.value.toString(),
          )
        : ImageTileContent(
            customImage: tile.customImage,
          );

    return InkWell(
      onTap: onTap,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            tileWidget,
          ],
        ),
      ),
    );
  }
}

class TextTileContent extends StatelessWidget {
  const TextTileContent({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}

class ImageTileContent extends StatelessWidget {
  const ImageTileContent({Key? key, this.customImage}) : super(key: key);

  /// Custom image for [Tile] to render
  final Uint8List? customImage;

  @override
  Widget build(BuildContext context) {
    return Image.memory(customImage!);
  }
}
