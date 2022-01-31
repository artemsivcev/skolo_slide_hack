import 'package:cropperx/cropperx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skolo_slide_hack/di/injector_provider.dart';
import 'package:skolo_slide_hack/domain/constants/colours.dart';
import 'package:skolo_slide_hack/domain/constants/durations.dart';
import 'package:skolo_slide_hack/domain/states/new_game_state.dart';
import 'package:skolo_slide_hack/presentation/screens/puzzle_page.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/background_with_bubbles.dart';
import 'package:skolo_slide_hack/presentation/widgets/background/glass_container.dart';
import 'package:skolo_slide_hack/presentation/widgets/buttons/button_widget.dart';
import 'package:skolo_slide_hack/presentation/widgets/common/row_column_solver.dart';
import 'package:skolo_slide_hack/presentation/widgets/polymorphic_container.dart';
import 'package:skolo_slide_hack/presentation/widgets/text_shadows.dart';

class NewGamePage extends StatefulWidget {
  const NewGamePage({Key? key}) : super(key: key);

  @override
  State<NewGamePage> createState() => _NewGamePageState();
}

class _NewGamePageState extends State<NewGamePage>
    with TickerProviderStateMixin {
  final newGameState = injector<NewGameState>();

  // Define a key
  final _cropperKey = GlobalKey(debugLabel: 'cropperKey');

  //crossfade state for buttons crop and play logic
  CrossFadeState _crossStateButtons = CrossFadeState.showFirst;

  Future<void> _cropImage() async {
    // Get the cropped image as bytes
    final imageBytes = await Cropper.crop(
      cropperKey: _cropperKey, // Reference it through the key
    );
    newGameState.chosenImage = null;
    newGameState.croppedImage = imageBytes;
  }

  @override
  Widget build(BuildContext buildContext) {
    return BackgroundWithBubbles(
      colorsBackground: colorsBackgroundMenu,
      child: Observer(builder: (context) {
        var showChosen = newGameState.chosenImage != null;
        var showCropped = newGameState.croppedImage != null;
        var showPreview = !showChosen && !showCropped;

        if (showChosen) {
          _crossStateButtons = CrossFadeState.showFirst;
        } else {
          _crossStateButtons = CrossFadeState.showSecond;
        }

        return Center(
          child: RowColumnSolver(
            children: [
              GlassContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(32.0),
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
                    InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async => {
                        await newGameState.chooseImagePress(),
                        newGameState.isBtnChooseImagePressed = false,
                      },
                      child: AnimatedContainer(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(showCropped ? 16.0 : 8.0),
                          border: Border.all(
                              color: colorsGreyMediumPrimary, width: 1.5),
                        ),
                        duration: const Duration(seconds: 2),
                        child: PolymorphicContainer(
                          userInnerStyle: true,
                          externalBorderRadius: showCropped ? 15.0 : 7.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  showCropped ? 16.0 : 8.0),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  if (showPreview)
                                    SvgPicture.asset(
                                      'assets/images/puzzle-continue.svg',
                                      color: colorsPurpleBluePrimary,
                                      height:
                                          newGameState.getImageMaxSize(context),
                                    )
                                  else
                                    const SizedBox(),
                                  AnimatedContainer(
                                    width: newGameState
                                        .getAnimatedContainerSize(context),
                                    height: newGameState
                                        .getAnimatedContainerSize(context),
                                    duration: const Duration(seconds: 2),
                                    curve: Curves.fastOutSlowIn,
                                    child: showCropped
                                        ? Image.memory(
                                            newGameState.croppedImage!.buffer
                                                .asUint8List(),
                                            fit: BoxFit.scaleDown,
                                          )
                                        : showChosen
                                            ? Cropper(
                                                backgroundColor: Colors.white,
                                                cropperKey: _cropperKey,
                                                overlayType:
                                                    OverlayType.rectangle,
                                                image: Image.memory(
                                                    newGameState.chosenImage!),
                                              )
                                            : const SizedBox(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GlassContainer(
                child: AnimatedCrossFade(
                  crossFadeState: _crossStateButtons,
                  duration: const Duration(seconds: 2),
                  firstChild: ButtonWidget(
                    iconUrl: 'assets/images/puzzle-new.svg',
                    btnText: 'Crop!',
                    isPressed: false,
                    onTap: () async {
                      _cropImage();
                    },
                  ),
                  secondChild: ButtonWidget(
                    iconUrl: 'assets/images/puzzle-new-filled.svg',
                    btnText: 'Play!',
                    isPressed: false,
                    onTap: () async {
                      await newGameState.playPress();
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const PuzzlePage(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
