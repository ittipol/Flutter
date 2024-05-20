import 'package:flutter_demo/presentation/views/common/web_view/web_view_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WebViewController extends StateNotifier<WebViewState> {

  WebViewController() : super(WebViewState());

  void updateLoadingPercentage(int? loadingPercentage) {
    state = state.copyWith(loadingPercentage: loadingPercentage);
  }
}