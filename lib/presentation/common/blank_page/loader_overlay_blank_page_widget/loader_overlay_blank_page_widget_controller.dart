import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoaderOverlayBlankPageWidgetController extends StateNotifier<bool> {

  LoaderOverlayBlankPageWidgetController() : super(false); 

  bool isLoaderOverlayShow() {
    return state;
  }

  void show() {
    state = true;
  }

  void hide() {
    state = false;
  }

}