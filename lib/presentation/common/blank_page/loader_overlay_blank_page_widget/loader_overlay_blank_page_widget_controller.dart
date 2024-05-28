import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoaderOverlayBlankPageWidgetController extends StateNotifier<bool> {

  LoaderOverlayBlankPageWidgetController() : super(false);  

  void show() {
    state = true;
  }

  void hide() {
    state = false;
  }

}