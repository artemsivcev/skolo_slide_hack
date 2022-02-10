import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/puzzle_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/text_shadows.dart';

class MovementsCounter extends StatelessWidget {
  const MovementsCounter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final moveAmount = injector<PuzzleState>().movementsCounter;

        return Semantics(
          label: "Amount of moves is $moveAmount",
          readOnly: true,
          child: Text(
            'Moves: $moveAmount',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              shadows: TextShadows.generateLongShadow(),
              fontWeight: FontWeight.w900,
              color: colorsPurpleBluePrimary,
            ),
          ),
        );
      },
    );
  }
}
