import 'package:flutter_demo/enum/screen_type.dart';

class AppScreenSetting {
  static ScreenType deviceScreenType = ScreenType.none;

  static bool get isMobile => AppScreenSetting.deviceScreenType == ScreenType.mobile;
  static bool get isTablet => AppScreenSetting.deviceScreenType == ScreenType.tablet;
  static bool get isDesktop => AppScreenSetting.deviceScreenType == ScreenType.desktop;
}