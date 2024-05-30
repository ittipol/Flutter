import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/config/app/app_color.dart';
import 'package:flutter_demo/config/app/app_config.dart';
import 'package:flutter_demo/config/route/route.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/presentation/common/blank_page/material_app_blank_widget/material_app_blank_widget.dart';
import 'package:flutter_demo/presentation/common/responsive_layout_builder/responsive_layout_builder.dart';
import 'package:flutter_demo/setting/app_theme_setting.dart';
import 'package:flutter_demo/provider/theme_provider.dart';
import 'package:flutter_demo/setting/on_boarding_screen_setting.dart';
import 'package:flutter_demo/utils/local_storage_utils.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  debugPrint("--------------------- ENV ======> [ ${AppConfig.env} ]");

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await LocalStorageUtils.clearKeychainValues();

  await AppThemeSetting.init();

  final showOnBoardingScreen = await OnBoardingScreenSetting.showOnBoardingScreen;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Future.delayed(const Duration(seconds: 2), () {
    FlutterNativeSplash.remove();
  });

  runApp(ProviderScope(
    child: MyApp(
      showOnBoardingScreen: showOnBoardingScreen,
    ),
  ));
}

class MyApp extends ConsumerWidget {
  final bool showOnBoardingScreen;

  const MyApp({
    required this.showOnBoardingScreen,
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {    

    final theme = ref.watch(themeProvider);

    return ResponsiveLayoutBuilder(
      desktop: _desktopBuild(theme),
      tablet: _tabletBuild(theme),
      mobile: _mobileBuild(theme),
      watch: _watchBuild(theme),
      notMatch: const MaterialAppBlankWidget(),
    );
  }  

  MaterialAppBlankWidget _desktopBuild(ThemeData theme) {
    return MaterialAppBlankWidget(
      theme: theme,
      home: const Center(
        child: Text(
          "Desktop",
          style: TextStyle(
            fontSize: 32,
            color: AppColor.primary
          )
        )
      )
    );
  }

  MaterialAppBlankWidget _tabletBuild(ThemeData theme) {
    return MaterialAppBlankWidget(
      theme: theme,
      initialRoute: showOnBoardingScreen ? RouteName.onBoardingScreenView : RouteName.home,
      onGenerateInitialRoutes: AppRouter.onGenerateInitialRoutes,
      onGenerateRoute: AppRouter.generateRoute,
      width: 768,
      height: 1280,
    );
  }

  MaterialAppBlankWidget _mobileBuild(ThemeData theme) {
    return MaterialAppBlankWidget(
      theme: theme,
      initialRoute: showOnBoardingScreen ? RouteName.onBoardingScreenView : RouteName.home,
      onGenerateInitialRoutes: AppRouter.onGenerateInitialRoutes,
      onGenerateRoute: AppRouter.generateRoute
    );
  }

  MaterialAppBlankWidget _watchBuild(ThemeData theme) {
    return MaterialAppBlankWidget(
      theme: theme,
      home: Container()
    );
  }
}
