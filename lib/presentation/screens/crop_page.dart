import 'dart:typed_data';

import 'package:cropperx/cropperx.dart';
import 'package:flutter/material.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/new_game_state.dart';

class CropPage extends StatefulWidget {
  const CropPage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final Uint8List image;

  @override
  _CropPageState createState() => _CropPageState();
}

class _CropPageState extends State<CropPage> {
  final newGameState = injector<NewGameState>();

  // Define a key
  final _cropperKey = GlobalKey(debugLabel: 'cropperKey');

  void _cropImage() async {
    // Get the cropped image as bytes
    final imageBytes = await Cropper.crop(
      cropperKey: _cropperKey, // Reference it through the key
    );
    newGameState.croppedImage = imageBytes;
    await Future.delayed(const Duration(microseconds: 1));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop You Image'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: _cropImage,
            tooltip: 'Crop',
            icon: const Icon(Icons.crop),
          )
        ],
      ),
      body: Container(
        color:  Colors.white,
        child: Hero(
          tag: "imageName",
          child: Cropper(
            backgroundColor: Colors.white,
            cropperKey: _cropperKey,
            overlayType: OverlayType.rectangle,
            image: Image.memory(widget.image),
          ),
        ),
      ),
    );
  }
}
