import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/choose_image_state.dart';

import '../text_shadows.dart';
import 'image_preview.dart';

class ImageChooser extends StatefulWidget {
  const ImageChooser({Key? key}) : super(key: key);

  @override
  _ImageChooserState createState() => _ImageChooserState();
}

class _ImageChooserState extends State<ImageChooser> {
  final chooseImageState = injector<ChooseImageState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Choose Image',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 24,
              shadows: TextShadows.generateLongShadow(),
              fontWeight: FontWeight.w900,
              color: colorsPurpleBluePrimary,
            ),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
            crossAxisCount: 2,
            children: List.generate(4, (index) {
              return ImagePreview();
            }),
        ),
      ],
    );
  }
}
