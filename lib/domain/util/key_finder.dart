import 'key_finder_stub.dart'
// ignore: uri_does_not_exist
    if (dart.library.io) 'package:skolo_slide_hack/domain/util/shared_pref_key_finder.dart'
// ignore: uri_does_not_exist
    if (dart.library.html) 'package:skolo_slide_hack/domain/util/web_key_finder.dart'
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
