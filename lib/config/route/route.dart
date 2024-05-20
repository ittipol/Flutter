import 'package:flutter/material.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_detail/api_service_detail_view.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_index/api_service_index_view.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_search/api_service_search_view.dart';
import 'package:flutter_demo/presentation/views/home/home_view.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo/ui_demo_view.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo_article/ui_demo_article_view.dart';
import 'package:flutter_demo/presentation/views/web_view_demo/web_view_demo/web_view_demo_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    debugPrint(">>>>>>>>>>>>>>> [onGenerateRoute] Route name ${settings.name}");
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
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Container(),
          ),
        );
    }
  }

}