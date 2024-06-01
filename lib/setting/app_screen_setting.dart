import 'package:flutter_demo/enum/screen_type.dart';

class AppScreenSetting {
  static ScreenType deviceScreenType = ScreenType.none;

  static bool get isMobile => AppScreenSetting.deviceScreenType == ScreenType.mobile;
}