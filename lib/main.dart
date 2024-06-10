import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/config/app/app_color.dart';
import 'package:flutter_demo/config/app/app_config.dart';
import 'package:flutter_demo/config/network/dio_option.dart';
import 'package:flutter_demo/config/route/route.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/config/route/tablet/tablet_route.dart';
import 'package:flutter_demo/data/app/api_base_url.dart';
import 'package:flutter_demo/data/app/authentication.dart';
import 'package:flutter_demo/data/data_sources/local/data_storage_local.dart';
import 'package:flutter_demo/data/data_sources/remote/authentication_remote.dart';
import 'package:flutter_demo/data/data_sources/remote/user_profile_remote.dart';
import 'package:flutter_demo/data/repositories/authentication_repository_impl.dart';
import 'package:flutter_demo/data/repositories/data_storage_repository_impl.dart';
import 'package:flutter_demo/data/repositories/user_profile_repository_impl.dart';
import 'package:flutter_demo/helper/authentication_helper.dart';
import 'package:flutter_demo/helper/on_boarding_screen_helper.dart';
import 'package:flutter_demo/helper/user_profile_helper.dart';
import 'package:flutter_demo/presentation/common/blank_page/material_app_blank_widget/material_app_blank_widget.dart';
import 'package:flutter_demo/presentation/common/responsive_layout_builder/responsive_layout_builder.dart';
import 'package:flutter_demo/helper/api_base_url_helper.dart';
import 'package:flutter_demo/helper/app_theme_helper.dart';
import 'package:flutter_demo/provider/theme_provider.dart';
import 'package:flutter_demo/helper/local_storage_helper.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  debugPrint("--------------------- ENV ======> [ ${AppConfig.env} ]");

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  ApiBaseUrlHelper.init();
  debugPrint("ApiBaseUrl.localhostBaseUrl ===> [ ${ApiBaseUrl.localhostBaseUrl} ]");

  await LocalStorageHelper.clearKeychainValues();

  await AuthenticationHelper.checkRefreshTokenStillActive(
    authenticationRepository: AuthenticationRepositoryImpl(
      authenticationRemoteDataSources: AuthenticationRemote(dio: DioOption().init(baseUrl: ApiBaseUrl.localhostBaseUrl))
    ),
    dataStorageRepository: DataStorageRepositoryImpl(
      dataStorageLocalDataSources: DataStorageLocal()
    ),
  );

  if(Authentication.isLoggedIn) {
    await UserProfileHelper.getUserProfile(userProfileRepository: UserProfileRepositoryImpl(
      userProfileRemoteDataSources: UserProfileRemote(dio: DioOption().init(baseUrl: ApiBaseUrl.localhostBaseUrl))
    ));
  }

  await AppThemeHelper.init();    

  final showOnBoardingScreen = await OnBoardingScreenHelper.showOnBoardingScreen;

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
