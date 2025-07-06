import 'dart:ui';

abstract final class AppColor {
  static const int _primaryColorValue = 0xff1565C0;
  static const CustomColor primary = CustomColor(_primaryColorValue);
}

final class CustomColor extends Color {
  const CustomColor(super.value);

  // Color get color => this;

  /// Percent which ranges from 0 to 100.
  Color percentAlpha(int percent) {

    if(percent < 0 || percent > 100) {
      return this;
    }

    return super.withAlpha((255 * (percent / 100)).toInt());
  }
}