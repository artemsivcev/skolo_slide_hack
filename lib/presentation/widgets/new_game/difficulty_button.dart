import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/buttons/radio_button.dart';

class DifficultyButton extends StatelessWidget {
  const DifficultyButton({
    Key? key,
    required this.semanticLabel,
    required this.dimensions,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String semanticLabel;
  final String dimensions;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      enabled: true,
      child: RadioButton(
        btnText: dimensions,
        child: SvgPicture.asset(
          'assets/images/selected.svg',
          color: colorsPurpleBluePrimary,
          height: 26,
        ),
        isPressed: isSelected,
        onTap: onTap,
      ),
    );
  }
}
