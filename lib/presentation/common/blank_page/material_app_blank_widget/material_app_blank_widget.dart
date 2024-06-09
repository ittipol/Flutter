import 'package:flutter/material.dart';
import 'package:flutter_demo/config/observer/route_history_observer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> baseContext = GlobalKey<NavigatorState>();

class MaterialAppBlankWidget extends ConsumerStatefulWidget {

  final ThemeData? theme;
  final Widget? home;
  final String? initialRoute;
  final List<Route<dynamic>> Function(String)? onGenerateInitialRoutes;
  final Route<dynamic>? Function(RouteSettings)? onGenerateRoute;
  final double width; 
  final double height;

  const MaterialAppBlankWidget({
    this.theme,
    this.home,
    this.initialRoute,
    this.onGenerateInitialRoutes,
    this.onGenerateRoute,
    this.width = 360,
    this.height = 690,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MaterialAppBlankWidget();
}

class _MaterialAppBlankWidget  extends ConsumerState<MaterialAppBlankWidget> {  

  @override
  Widget build(BuildContext context) {    
    return ScreenUtilInit(
      designSize: Size(widget.width, widget.height),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Flutter',           
          theme: widget.theme,
          // theme: lightMode,
          // darkTheme: darkMode,
          // themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          navigatorKey: baseContext,
          home: widget.home,
          initialRoute: widget.initialRoute,
          onGenerateInitialRoutes: widget.onGenerateInitialRoutes,
          onGenerateRoute: widget.onGenerateRoute,    
          navigatorObservers: [RouteHistoryObserver()],      
        );
      }
    );
  }
}