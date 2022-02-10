import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/text_shadows.dart';

class GameTimer extends StatelessWidget {
  GameTimer({
    Key? key,
  }) : super(key: key);

  final puzzleState = injector<PuzzleState>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Text(
          '${puzzleState.minutes}:'
          '${puzzleState.seconds}',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: colorsPurpleBluePrimary,
          ),
        );
      },
    );
  }
}
