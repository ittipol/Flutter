import 'package:flutter_demo/helper/app_theme_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final darkModeSelectProvider = StateProvider.autoDispose<bool>((ref) => AppThemeHelper.isDarkModeEnabled);