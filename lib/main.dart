import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app/app_config.dart';
import 'package:flutter_demo/config/observer/route_history_observer.dart';
import 'package:flutter_demo/config/route/route.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  debugPrint("--------------------- ENV ======> [ ${AppConfig.env} ]");

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {    
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: appTheme(),
          initialRoute: RouteName.home,
          onGenerateRoute: AppRouter.generateRoute,    
          navigatorObservers: [RouteHistoryObserver()],      
        );
      }
    );
  }
}