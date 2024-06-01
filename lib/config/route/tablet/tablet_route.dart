import 'package:flutter/material.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/presentation/views/tablet/home/home_view.dart';

final class TabletAppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    debugPrint(">>>>>>>>>>>>>>> [Tablet] [onGenerateRoute] Route name ${settings.name}");
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(settings: const RouteSettings(name: RouteName.home), builder: (_) => const TabletHomeView());
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
          MaterialPageRoute(settings: const RouteSettings(name: RouteName.home), builder: (_) => const TabletHomeView())
        ];
      default:
    }

    return [];
  }

}