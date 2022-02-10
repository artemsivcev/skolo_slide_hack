import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/states/choose_image_state.dart';

import '../text_shadows.dart';
import 'default_preview.dart';
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
        Row(
          children: [
            DefaultPreview(
              imageIndex: 0,
            ),
            DefaultPreview(
              imageIndex: 1,
            ),
          ],
        ),
        Row(
          children: [
            DefaultPreview(
              imageIndex: 2,
            ),
            ImagePreview()
          ],
        ),
      ],
    );
  }
}
