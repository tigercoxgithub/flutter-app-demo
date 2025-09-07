import 'package:flutter/foundation.dart';
import 'package:universal_platform/universal_platform.dart';

class PlatformUtils {
  static bool get isWeb => kIsWeb;
  static bool get isMacOS => UniversalPlatform.isMacOS;
  static bool get isDesktop => UniversalPlatform.isDesktop;
  static bool get isMobile => UniversalPlatform.isMobile;

  static String get platformName {
    if (isWeb) return 'Web';
    if (isMacOS) return 'macOS';
    return 'Unknown';
  }
}
