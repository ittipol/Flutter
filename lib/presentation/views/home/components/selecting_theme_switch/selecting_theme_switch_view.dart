import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app/app_theme.dart';
import 'package:flutter_demo/helper/app_theme_helper.dart';
import 'package:flutter_demo/presentation/views/home/home_provider.dart';
import 'package:flutter_demo/provider/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectingThemeSwitchView extends ConsumerStatefulWidget {

  const SelectingThemeSwitchView({
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectingThemeSwitchView();
}

class _SelectingThemeSwitchView  extends ConsumerState<SelectingThemeSwitchView> {

  @override
  Widget build(BuildContext context) {

    final isDarkMode = ref.watch(darkModeSelectProvider);

    return SwitchListTile(                
      title: Text(
        "Dark mode",
        style: const TextStyle().copyWith(
          fontSize: 16.spMin,
          fontWeight: FontWeight.w700
        ),
      ),
      contentPadding: EdgeInsets.zero,
      value: isDarkMode,
      onChanged: (value) async {
        await AppThemeHelper.setDarkMode(value);
        ref.read(themeProvider.notifier).state = AppTheme.getTheme();
        ref.read(darkModeSelectProvider.notifier).state = value;
      },
      controlAffinity: ListTileControlAffinity.trailing,
    );
  }
}