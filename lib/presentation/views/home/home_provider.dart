import 'package:flutter_demo/setting/app_theme_setting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final darkModeSelectProvider = StateProvider.autoDispose<bool>((ref) => AppThemeSetting.isDarkModeEnabled);