import 'package:flutter_demo/core/isolate/isolate_builder.dart';
import 'package:flutter_demo/core/isolate/simple_isolate.dart';
import 'package:flutter_demo/helper/math_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsolateDemoController extends StateNotifier<int> {

  IsolateDemoController() : super(0); 

  void update(int value) {
    state = value;
  }

  void fibonacci({required int input}) {
    state =  MathHelper.fibonacci(input);
  }

  Future<void> isolateFibonacci({required int input}) async {
    final isolate = IsolateBuilder();
    state = await isolate.compute((message) {
      return MathHelper.fibonacci(message);
    }, input);
  }

  Future<void> simpleIsolateFibonacci({required int input}) async {
    state = await SimpleIsolate.compute(() {
      return MathHelper.fibonacci(input);
    });
  }

}