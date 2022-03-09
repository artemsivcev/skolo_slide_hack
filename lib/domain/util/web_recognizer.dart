import 'package:flutter/foundation.dart';
import 'package:skolo_slide_hack/domain/util/key_finder.dart';

class WebRecognizer implements PlatformRecognizer {
  @override
  bool isDesktop() => kIsWeb;

  @override
  bool isMobile() => false;

  @override
  bool isWeb() => true;
}

PlatformRecognizer getPlatform() => WebRecognizer();
