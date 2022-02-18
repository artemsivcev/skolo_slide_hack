import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SkoloIcon extends StatelessWidget {
  const SkoloIcon({
    Key? key,
    this.height = 48,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Link to Skolopendra web site",
      enabled: true,
      child: InkWell(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async => {launch("https://skolopendra.com/")},
        child: SvgPicture.asset(
          'assets/images/skolo.svg',
          color: Colors.black,
          height: height,
        ),
      ),
    );
  }
}
