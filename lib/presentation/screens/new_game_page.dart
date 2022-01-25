import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/states/new_game_state.dart';
import 'package:skolo_slide_hack/presentation/widgets/menu_screen/menu_button_widget.dart';
import 'package:skolo_slide_hack/presentation/widgets/polymorphic_container.dart';

import 'crop_page.dart';

class NewGamePage extends StatefulWidget {
  const NewGamePage({Key? key}) : super(key: key);

  @override
  State<NewGamePage> createState() => _NewGamePageState();
}

class _NewGamePageState extends State<NewGamePage> {
  final newGameState = injector<NewGameState>();

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Observer(
            builder: (context) {
              return PolymorphicContainer(
                userInnerStyle: true,
                child: Row(
                  children: [
                    MenuButtonWidget(
                      iconUrl: 'assets/images/puzzle-continue.svg',
                      btnText: 'Choose image',
                      isPressed: newGameState.isBtnChooseImagePressed,
                      onTap: () async {
                        var imageData = await newGameState.chooseImagePress();
                        if (imageData != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CropPage(
                                image: imageData,
                              ),
                            ),
                          );
                        } else {
                          print("bye");
                        }
                      },
                    ),
                    const SizedBox(width: 26),
                    newGameState.croppedImage != null
                        ? PolymorphicContainer(
                          userInnerStyle: true,
                          child: Image.memory(
                            newGameState.croppedImage!.buffer.asUint8List(),
                            width: 250,
                            height: 250,
                            fit: BoxFit.scaleDown,
                          ),
                        )
                        : Container(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
