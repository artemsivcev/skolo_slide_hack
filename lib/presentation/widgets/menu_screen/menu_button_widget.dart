import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';

class MenuButtonWidget extends StatelessWidget {
  const MenuButtonWidget(
      {Key? key, required this.iconUrl, required this.btnText})
      : super(key: key);

  ///Url for button icon
  final String iconUrl;

  ///Button text
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {},
      child: Column(
        children: [
          Container(
            height: 100.0,
            width: 100.0,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SvgPicture.asset(
                iconUrl,
                color: colorsPurpleBluePrimary,
              ),
            ),
            decoration: const BoxDecoration(
                color: colorsGreyMediumPrimary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(3.0, 3.0),
                      blurRadius: 5.0,
                      spreadRadius: 0.5,
                      color: colorsGreyDarkPrimary),
                  BoxShadow(
                      offset: Offset(-3.0, -3.0),
                      blurRadius: 5.0,
                      spreadRadius: 0.5,
                      color: colorsWhitePrimary),
                ]),
          ),
          const SizedBox(height: 20),
          Text(btnText,
              style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: colorsGreyDarkPrimary))
        ],
      ),
    );
  }
}
