import 'package:flutter_demo/presentation/views/isolate_demo/isolate_demo_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final isolateDemoProvider = StateNotifierProvider.autoDispose<IsolateDemoController, int>(
  (ref) => IsolateDemoController(),  
);