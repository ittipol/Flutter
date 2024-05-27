import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app/app_color.dart';

sealed class LoaderOverlay {

  static bool _isShow = false;

  // static final LoaderOverlay _singleton = LoaderOverlay._internal();
  // LoaderOverlay._internal();
  // factory LoaderOverlay() {
  //   return _singleton;
  // }

  static void show(BuildContext context) async {

    if(_isShow) {
      return;
    }

    _isShow = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,      
      builder: (context) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (didPop) {
              return;
            }
          },
          child: Container(
            color: Colors.black54.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: AppColor.primary
              )
            ),
          )
        );
      }
    );
  }

  static void hide(BuildContext context) {
    if(Navigator.canPop(context) && _isShow) {
      Navigator.pop(context);
      _isShow = false;
    }
  }

}