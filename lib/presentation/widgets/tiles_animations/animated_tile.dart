import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/models/tile.dart';
import 'package:skolo_slide_hack/domain/states/start_animation_state.dart';
import 'package:skolo_slide_hack/domain/states/tile_animation_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/polymorphic_container_pure.dart';
import 'package:skolo_slide_hack/presentation/widgets/tiles_animations/tile_start_play_animator.dart';

class AnimatedTile extends StatelessWidget {
  AnimatedTile({Key? key, required this.tile}) : super(key: key);

  final Tile tile;

  final TileAnimationState _animatedTileState = injector<TileAnimationState>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        final animationPhase = _animatedTileState.currentAnimationPhase;

        if (animationPhase == null) {
          return SizedBox();
        }

        final animationController;
        switch (animationPhase) {

          /// for TileAnimationPhase.START_ANIMATION
          default:
            animationController =
                injector<StartAnimationState>().startAnimationController;
        }

        return AnimatedBuilder(
          animation: animationController!,
          builder: (_, child) {
            if (animationPhase == TileAnimationPhase.START_ANIMATION) {
              return TileStartAnimator(child: child!);
            }

            // for TileAnimationPhase.NORMAL
            return PolymorphicContainerPure(child: child!);
          },
          child: TileToShow(
            tile: tile,
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
  }) : super(key: key);

  final Tile tile;

  @override
  Widget build(BuildContext context) {
    final tileWidget = tile.customImage == null
        ? TextTileContent(
            title: tile.value.toString(),
          )
        : ImageTileContent(
            customImage: tile.customImage,
          );

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          tileWidget,
        ],
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
