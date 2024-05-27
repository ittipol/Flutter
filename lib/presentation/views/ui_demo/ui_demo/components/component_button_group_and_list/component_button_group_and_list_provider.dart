import 'package:flutter_demo/presentation/views/ui_demo/ui_demo/components/component_button_group_and_list/component_button_group_and_list_controller.dart';
import 'package:flutter_demo/presentation/views/ui_demo/ui_demo/components/component_button_group_and_list/component_button_group_and_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final componentButtonGroupAndListProvider = StateNotifierProvider.autoDispose<ComponentButtonGroupAndListController, ComponentButtonGroupAndListState>(
  (ref) => ComponentButtonGroupAndListController(),  
);