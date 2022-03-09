import 'dart:io';

import 'package:skolo_slide_hack/domain/util/key_finder.dart';

class IORecognizer implements PlatformRecognizer {
  @override
  bool isDesktop() =>
      Platform.isWindows || Platform.isMacOS || Platform.isLinux;

  @override
  bool isMobile() => Platform.isIOS || Platform.isAndroid;

  @override
  bool isWeb() => false;
}

PlatformRecognizer getKeyFinder() => IORecognizer();
