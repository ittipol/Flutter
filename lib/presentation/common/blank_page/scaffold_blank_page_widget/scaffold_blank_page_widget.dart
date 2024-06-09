import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/presentation/common/blank_page/app_bar_widget/app_bar_widget.dart';
import 'package:flutter_demo/setting/app_theme_setting.dart';
import 'package:flutter_demo/presentation/common/blank_page/loader_overlay_blank_page_widget/loader_overlay_blank_page_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScaffoldBlankPageWidget extends ConsumerStatefulWidget {

  final AppBarWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? bottomSheet;  
  final bool resizeToAvoidBottomInset;
  final bool useSafeArea;
  final bool systemNavigationBack;
  final void Function()? systemNavigationBackCallBack;

  const ScaffoldBlankPageWidget({
    this.appBar,
    this.body,
    this.bottomNavigationBar,
    this.drawer,
    this.bottomSheet,
    this.resizeToAvoidBottomInset = false,
    this.useSafeArea = true,
    this.systemNavigationBack = false,
    this.systemNavigationBackCallBack,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScaffoldBlankPageWidget();
}

class _ScaffoldBlankPageWidget  extends ConsumerState<ScaffoldBlankPageWidget> {
  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        debugPrint("==============>>>>> didPop [ $didPop ]");
        if (didPop) {
          return;
        }

        if (widget.systemNavigationBack) {      
          if (widget.systemNavigationBackCallBack != null) {
            widget.systemNavigationBackCallBack?.call();
          } else {
            if(Navigator.canPop(context)) Navigator.pop(context);
          }          
        }

      },
      child: GestureDetector(
        onTap: (){
          _hideKeyboard(context);
        },
        child: LoaderOverlayBlankPageWidget(
          body: Scaffold(
            appBar: widget.appBar,            
            body: _safeArea(useSafeArea: widget.useSafeArea, body: widget.body ?? Container()),
            bottomNavigationBar: widget.bottomNavigationBar,
            drawer: widget.drawer,
            bottomSheet: widget.bottomSheet,
            resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          ),
        ),
      ),
    );
  }

  Widget _safeArea({required bool useSafeArea, required Widget body}) {    

    if(useSafeArea) {
      return SafeArea(
        child: _annotatedRegion(body)
      );
    }

    return _annotatedRegion(body);
  }

  Widget _annotatedRegion(Widget body) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _statusBarColor(),
      child: body,
    );
  }

  SystemUiOverlayStyle _statusBarColor() {

    var darkMode = AppThemeSetting.isDarkModeEnabled;

    const light = SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    );

    const dark = SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark
    );

    return darkMode ? dark : light;
  }

  void _hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}