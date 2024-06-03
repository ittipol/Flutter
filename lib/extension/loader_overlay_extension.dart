import 'package:flutter_demo/presentation/common/blank_page/loader_overlay_blank_page_widget/loader_overlay_blank_page_widget_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension LoaderOverlayExtension on WidgetRef {

  bool get isLoaderOverlayShow => read(isShowLoaderOverlayProvider.notifier).isLoaderOverlayShow();

  void showLoaderOverlay() {
    read(isShowLoaderOverlayProvider.notifier).show();
  }

  void hideLoaderOverlay() {
    read(isShowLoaderOverlayProvider.notifier).hide();
  }
}