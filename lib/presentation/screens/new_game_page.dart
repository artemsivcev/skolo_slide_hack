import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 42.0),
                child: PolymorphicContainer(
                  userInnerStyle: true,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MenuButtonWidget(
                          iconUrl: 'assets/images/puzzle-continue.svg',
                          btnText: 'Choose image',
                          isPressed: newGameState.isBtnChooseImagePressed,
                          onTap: () async {
                            var imageData =
                                await newGameState.chooseImagePress();
                            if (imageData != null) {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(seconds: 2),
                                  pageBuilder: (_, __, ___) => CropPage(
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
                        Hero(
                          transitionOnUserGestures: true,
                          tag: "imageName",
                          child: Container(
                            child: newGameState.croppedImage != null
                                ? Image.memory(
                                    newGameState.croppedImage!.buffer
                                        .asUint8List(),
                                    width: 225,
                                    height: 225,
                                    fit: BoxFit.scaleDown,
                                  )
                                : SvgPicture.asset(
                                    'assets/images/puzzle-new-filled.svg',
                                    color: colorsPurpleBluePrimary,
                                    width: 225,
                                    height: 225,
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
