import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class GitHubIcon extends StatelessWidget {
  const GitHubIcon({
    Key? key,
    this.height = 48,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Go to source code",
      enabled: true,
      child: InkWell(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async =>
            {launch("https://github.com/artemsivcev/skolo_slide_hack")},
        child: SvgPicture.asset(
          'assets/images/github.svg',
          color: Colors.black,
          height: height,
        ),
      ),
    );
  }
}
