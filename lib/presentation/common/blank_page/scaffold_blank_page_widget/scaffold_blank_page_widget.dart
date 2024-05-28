import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/presentation/common/blank_page/loader_overlay_blank_page_widget/loader_overlay_blank_page_widget.dart';
import 'package:flutter_demo/presentation/views/home/home_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScaffoldBlankPageWidget extends ConsumerStatefulWidget {

  final AppBar? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;
  final bool useSafeArea;

  const ScaffoldBlankPageWidget({
    this.appBar,
    this.body,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = false,
    this.useSafeArea = true,
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
        if (didPop) {
          return;
        }
      },
      child: GestureDetector(
        onTap: (){
          _hideKeyboard(context);
        },
        child: Scaffold(
          appBar: widget.appBar,
          body: LoaderOverlayBlankPageWidget(
            body: _safeArea(useSafeArea: widget.useSafeArea, body: widget.body ?? Container()),
          ),
          bottomNavigationBar: widget.bottomNavigationBar,
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
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

    var darkMode = ref.read(darkModeSelectProvider.notifier).state;

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