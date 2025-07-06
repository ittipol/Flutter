import 'package:flutter/material.dart';
import 'package:flutter_demo/presentation/common/blank_page/loader_overlay_blank_page_widget/loader_overlay_blank_page_widget_provider.dart';
import 'package:flutter_demo/presentation/common/blank_page/material_app_blank_widget/material_app_blank_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension LoaderOverlayExtension on BuildContext {

  static final _parentRef = ProviderScope.containerOf(baseContext.currentContext!);

  bool get isLoaderOverlayShow => _parentRef.read(isShowLoaderOverlayProvider.notifier).isLoaderOverlayShow();
  
  void showLoaderOverlay() {    
    if(!_parentRef.read(isShowLoaderOverlayProvider.notifier).isLoaderOverlayShow()) {
      _parentRef.read(isShowLoaderOverlayProvider.notifier).show();
    }
  }

  void hideLoaderOverlay() {
    if(_parentRef.read(isShowLoaderOverlayProvider.notifier).isLoaderOverlayShow()) {
      _parentRef.read(isShowLoaderOverlayProvider.notifier).hide();
    }
  }
}

// extension LoaderOverlayExtension on WidgetRef {

//   bool get isLoaderOverlayShow => read(isShowLoaderOverlayProvider.notifier).isLoaderOverlayShow();

//   void showLoaderOverlay() {
//     read(isShowLoaderOverlayProvider.notifier).show();
//   }

//   void hideLoaderOverlay() {
//     read(isShowLoaderOverlayProvider.notifier).hide();
//   }
// }