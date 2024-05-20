import 'package:flutter_demo/presentation/views/common/web_view/web_view_controller.dart';
import 'package:flutter_demo/presentation/views/common/web_view/web_view_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final webViewProvider = StateNotifierProvider.autoDispose<WebViewController, WebViewState>(
  (ref) => WebViewController(),
);