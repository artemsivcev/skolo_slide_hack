// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/presentation/widgets/buttons/buttons_group_widget.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorsGreyLightPrimary,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '''Puzzle 
       Game''',
              style: TextStyle(fontFamily: 'LuckiestGuy-Regular', fontSize: 84),
            ),
            const SizedBox(height: 30),
            ButtonsGroupWidget(),
          ],
        )));
  }
}
