import 'package:flutter_demo/presentation/views/ui_demo/ui_demo/components/component_one/component_one_controller.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo/components/component_one/component_one_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final componentOneProvider = StateNotifierProvider.autoDispose<ComponentOneController, ComponentOneState>(
  (ref) => ComponentOneController(),  
);