import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DashIcon extends StatelessWidget {
  const DashIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Semantics(
        label: "Image of Dash and link to flutter website",
        enabled: true,
        child: InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async => {launch("https://flutter.com")},
          child: Image.asset(
            'assets/images/dash.png',
            width: 210,
          ),
        ),
      ),
    );
  }
}
