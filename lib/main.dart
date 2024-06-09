import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/config/app/app_color.dart';
import 'package:flutter_demo/config/app/app_config.dart';
import 'package:flutter_demo/config/route/route.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/config/route/tablet/tablet_route.dart';
import 'package:flutter_demo/data/app/authentication.dart';
import 'package:flutter_demo/helper/authentication_helper.dart';
import 'package:flutter_demo/helper/helper.dart';
import 'package:flutter_demo/helper/user_profile_helper.dart';
import 'package:flutter_demo/presentation/common/blank_page/material_app_blank_widget/material_app_blank_widget.dart';
import 'package:flutter_demo/presentation/common/responsive_layout_builder/responsive_layout_builder.dart';
import 'package:flutter_demo/setting/app_api_url_setting.dart';
import 'package:flutter_demo/setting/app_theme_setting.dart';
import 'package:flutter_demo/provider/theme_provider.dart';
import 'package:flutter_demo/setting/on_boarding_screen_setting.dart';
import 'package:flutter_demo/helper/local_storage_helper.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  debugPrint("--------------------- ENV ======> [ ${AppConfig.env} ]");

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  AppApiUrlSetting.localHostUrl = Helper.getLocalhostUrl();

  await LocalStorageHelper.clearKeychainValues();
  await AuthenticationHelper.getToken();

  if(Authentication.isLoggedIn) {
    debugPrint("ZZZZ  +++++++++++++>>>>>>>>>>>>>> MAIN >>> Authentication.isLoggedIn >>>>>> [ TEUE ]");
    await UserProfileHelper.getUserProfile();
  }

  await AppThemeSetting.init();  

  debugPrint("AppApiUrlSetting.localHostUrl ===> [ ${AppApiUrlSetting.localHostUrl} ]");

  final showOnBoardingScreen = await OnBoardingScreenSetting.showOnBoardingScreen;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
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
      desktopAll: (ctx) {
        return _desktopBuild(theme);
      },
      tabletAll: (ctx) {
        return _tabletBuild(theme);
      },
      mobileAll: (ctx) {
        return _mobileBuild(theme);
      },
      watchAll: (ctx) {
        return _watchBuild(theme);
      },
      webAppAll: (ctx) {
        return _webAppBuild(theme);
      },
      notMatchAll: (ctx) {
        return const MaterialAppBlankWidget();
      },
    );
  }  

  MaterialAppBlankWidget _desktopBuild(ThemeData theme) {
    return MaterialAppBlankWidget(
      theme: theme,
      home: Container(
        color: Colors.black,
        child: const Center(
          child: Text(
            "Desktop",
            style: TextStyle(
              fontSize: 32,
              color: AppColor.primary
            )
          )
        ),
      )
    );
  }

  MaterialAppBlankWidget _tabletBuild(ThemeData theme) {
    return MaterialAppBlankWidget(
      theme: theme,
      initialRoute: RouteName.home,
      onGenerateInitialRoutes: TabletAppRouter.onGenerateInitialRoutes,
      onGenerateRoute: TabletAppRouter.generateRoute,
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

  MaterialAppBlankWidget _webAppBuild(ThemeData theme) {
    return MaterialAppBlankWidget(
      theme: theme,
      initialRoute: showOnBoardingScreen ? RouteName.onBoardingScreenView : RouteName.home,
      onGenerateInitialRoutes: AppRouter.onGenerateInitialRoutes,
      onGenerateRoute: AppRouter.generateRoute
    );
  }
}
