import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app/app_config.dart';
import 'package:flutter_demo/config/observer/route_history_observer.dart';
import 'package:flutter_demo/config/route/route.dart';
import 'package:flutter_demo/config/route/route_name.dart';
import 'package:flutter_demo/config/theme/theme_provider.dart';
import 'package:flutter_demo/utils/local_storage_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  debugPrint("--------------------- ENV ======> [ ${AppConfig.env} ]");

  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageUtils.clearKeychainValues();

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {    

    final theme = ref.watch(themeProvider);

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: theme,
          // theme: lightMode,
          // darkTheme: darkMode,
          // themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          initialRoute: RouteName.home,
          onGenerateRoute: AppRouter.generateRoute,    
          navigatorObservers: [RouteHistoryObserver()],      
        );
      }
    );
  }
}
