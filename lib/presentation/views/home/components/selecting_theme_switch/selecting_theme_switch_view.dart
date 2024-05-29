import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app/app_theme.dart';
import 'package:flutter_demo/setting/app_theme_setting.dart';
import 'package:flutter_demo/presentation/views/home/home_provider.dart';
import 'package:flutter_demo/provider/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      title: const Text("Dark mode"),
      contentPadding: EdgeInsets.zero,
      value: isDarkMode,
      onChanged: (value) async {
        await AppThemeSetting.setDarkMode(value);
        ref.read(themeProvider.notifier).state = AppTheme.getTheme();
        ref.read(darkModeSelectProvider.notifier).state = value;
      },
      controlAffinity: ListTileControlAffinity.trailing,
    );
  }
}