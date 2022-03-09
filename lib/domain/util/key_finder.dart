import 'platform_recognizer_stub.dart'
// ignore: uri_does_not_exist
    if (dart.library.io) 'package:skolo_slide_hack/domain/util/io_recognizer.dart'
// ignore: uri_does_not_exist
    if (dart.library.html) 'package:skolo_slide_hack/domain/util/web_recognizer.dart'
    as plt;

///Recognize a platform of used devices.
///Safe using with web and devices witch supports I/O.
abstract class PlatformRecognizer {
  bool isDesktop();
  bool isWeb();
  bool isMobile();

  /// factory constructor to return the correct implementation.
  factory PlatformRecognizer() => plt.getPlatform();
}
