import 'package:flutter_demo/presentation/common/blank_page/loader_overlay_blank_page_widget/loader_overlay_blank_page_widget_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isShowLoaderOverlayProvider = StateNotifierProvider<LoaderOverlayBlankPageWidgetController, bool>(
  (ref) => LoaderOverlayBlankPageWidgetController(),  
);