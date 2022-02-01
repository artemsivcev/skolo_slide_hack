import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class GitHubIcon extends StatelessWidget {
  const GitHubIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.topLeft,
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
            height: 50,
          ),
        ),
      ),
    );
  }
}
