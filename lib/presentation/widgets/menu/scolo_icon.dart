import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SkoloIcon extends StatelessWidget {
  const SkoloIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Semantics(
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
                height: 50,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
