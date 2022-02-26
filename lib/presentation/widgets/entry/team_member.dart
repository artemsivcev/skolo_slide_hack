import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/glass_container.dart';

class TeamMember extends StatelessWidget {
  const TeamMember({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      color: colorsGreyDarkPrimary.withOpacity(0.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Image.asset(
              'assets/images/avatar_${name.toLowerCase()}.png',
              width: 200,
              height: 220,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 2),
          SizedBox(
            width: 200,
            height: 70,
            child: Center(
              child: Text(
                name,
                style: const TextStyle(
                  fontFamily: 'AmaticSC',
                  fontSize: 46,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w900,
                  color: colorsPurpleBluePrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
