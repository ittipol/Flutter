import 'package:flutter_demo/presentation/views/ui_demo/ui_demo/components/component_one/component_one_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComponentOneController extends StateNotifier<ComponentOneState> {

  ComponentOneController() : super(ComponentOneState());

  void buttonSelect(ComponentOneButton selectedButton) {
    state = state.copyWith(selectedButton: selectedButton);
  }

}