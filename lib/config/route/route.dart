import 'package:flutter/material.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_detail/api_service_detail_view.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_index/api_service_index_view.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_search/api_service_search_view.dart';
import 'package:flutter_demo/presentation/views/home/home_view.dart';
import 'package:flutter_demo/presentation/views/isolate_demo/isolate_demo_view.dart';
import 'package:flutter_demo/presentation/views/local_storage_demo/local_storage_demo_view.dart';
import 'package:flutter_demo/presentation/views/on_boarding_screen/on_boarding_screen_view.dart';
import 'package:flutter_demo/presentation/views/pdf_viewer_demo/pdf_viewer_demo_view.dart';
import 'package:flutter_demo/presentation/views/platform_channel/platform_channel_view.dart';
import 'package:flutter_demo/presentation/views/responsive_design/responsive_design_view.dart';
import 'package:flutter_demo/presentation/views/screen_capture/screen_capture_view.dart';
import 'package:flutter_demo/presentation/views/sliver_app_bar/sliver_app_bar_view.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo/ui_demo_view.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo_article/ui_demo_article_view.dart';
import 'package:flutter_demo/presentation/views/user/user_home/user_home_view.dart';
import 'package:flutter_demo/presentation/views/user/user_login/user_login_view.dart';
import 'package:flutter_demo/presentation/views/user/user_register/user_register_view.dart';
import 'package:flutter_demo/presentation/views/web_view_demo/web_view_demo/web_view_demo_view.dart';

final class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    debugPrint(">>>>>>>>>>>>>>> [Mobile] [onGenerateRoute] Route name ${settings.name}");
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(settings: const RouteSettings(name: RouteName.home), builder: (_) => const HomeView());
      case RouteName.apiServiceIndexView:
        return MaterialPageRoute(settings: const RouteSettings(name: RouteName.apiServiceIndexView), builder: (_) => const ApiServiceIndexView());
      case RouteName.apiServiceSearchView:
        return MaterialPageRoute(settings: const RouteSettings(name: RouteName.apiServiceSearchView), builder: (_) => const ApiServiceSearchView());
      case RouteName.apiServiceDetailView:
        final args = settings.arguments as ApiServiceDetailViewArgs;
        return MaterialPageRoute(settings: const RouteSettings(name: RouteName.apiServiceDetailView), builder: (_) => ApiServiceDetailView(args: args));
      case RouteName.uiDemoView:
        return MaterialPageRoute(settings: const RouteSettings(name: RouteName.uiDemoView), builder: (_) => const UiDemoView());
      case RouteName.uiDemoArticleView:
        final args = settings.arguments as UiDemoArticleViewArgs;
        return MaterialPageRoute(settings: const RouteSettings(name: RouteName.uiDemoArticleView), builder: (_) => UiDemoArticleView(args: args));
      case RouteName.webViewDemoView:
        return MaterialPageRoute(settings: const RouteSettings(name: RouteName.webViewDemoView), builder: (_) => const WebViewDemoView());
      case RouteName.sliverAppBarView:
        return MaterialPageRoute(settings: const RouteSettings(name: RouteName.sliverAppBarView), builder: (_) => const SliverAppBarView());
      case RouteName.localStorageDemoView:
        return MaterialPageRoute(settings: const RouteSettings(name: RouteName.localStorageDemoView), builder: (_) => const LocalStorageDemoView());
      case RouteName.screenCaptureView:
        return MaterialPageRoute(settings: const RouteSettings(name: RouteName.screenCaptureView), builder: (_) => const ScreenCaptureView());
      case RouteName.onBoardingScreenView:
        return MaterialPageRoute(settings: const RouteSettings(name: RouteName.onBoardingScreenView), builder: (_) => const OnBoardingScreenView());
      case RouteName.responsiveDesignView:
        return MaterialPageRoute(settings: const RouteSettings(name: RouteName.responsiveDesignView), builder: (_) => const ResponsiveDesignView());
      case RouteName.platformChannelView:
        return MaterialPageRoute(settings: const RouteSettings(name: RouteName.platformChannelView), builder: (_) => const PlatformChannelView());
      case RouteName.isolateDemoView:
        return MaterialPageRoute(settings: const RouteSettings(name: RouteName.isolateDemoView), builder: (_) => const IsolateDemoView());
      case RouteName.userHomeView:
        return MaterialPageRoute(settings: const RouteSettings(name: RouteName.userHomeView), builder: (_) => const UserHomeView());
      case RouteName.userLoginView:
        return MaterialPageRoute(settings: const RouteSettings(name: RouteName.userLoginView), builder: (_) => const UserLoginView());
      case RouteName.userRegisterView:
        return MaterialPageRoute(settings: const RouteSettings(name: RouteName.userRegisterView), builder: (_) => const UserRegisterView());
      case RouteName.pdfViewerView:
        return MaterialPageRoute(settings: const RouteSettings(name: RouteName.pdfViewerView), builder: (_) => const PdfViewerView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Container(),
          ),
        );
    }    
  }

  static List<Route<dynamic>> onGenerateInitialRoutes(String initialRoute) {
    switch (initialRoute) {
      case RouteName.home:
        return [
          MaterialPageRoute(settings: const RouteSettings(name: RouteName.home), builder: (_) => const HomeView())
        ];
      case RouteName.onBoardingScreenView:
        return [
          MaterialPageRoute(settings: const RouteSettings(name: RouteName.onBoardingScreenView), builder: (_) => const OnBoardingScreenView())
        ];
      default:
    }

    return [];
  }

}