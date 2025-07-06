enum ScreenType { 
  none(0),
  mobile(1),
  tablet(2),
  desktop(3),
  watch(4);

  const ScreenType(this.value);
  final num value;

  static ScreenType getByValue(num i) {
    return ScreenType.values.firstWhere((x) => x.value == i, orElse: () => defaultValue);
  }

  static ScreenType defaultValue = none;
}