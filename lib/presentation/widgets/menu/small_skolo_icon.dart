import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SmallSkoloIcon extends StatelessWidget {
  const SmallSkoloIcon({Key? key}) : super(key: key);

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
        child: Image.asset(
          'assets/images/skolo_small_icon.png',
          color: Colors.black,
          height: 50,
        ),
      ),
    );
  }
}
