import 'package:flutter_demo/enum/screen_type.dart';

class AppScreenHelper {
  static ScreenType deviceScreenType = ScreenType.none;

  static bool get isMobile => AppScreenHelper.deviceScreenType == ScreenType.mobile;
  static bool get isTablet => AppScreenHelper.deviceScreenType == ScreenType.tablet;
  static bool get isDesktop => AppScreenHelper.deviceScreenType == ScreenType.desktop;
}