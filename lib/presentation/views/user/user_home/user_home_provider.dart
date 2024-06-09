import 'package:flutter_demo/presentation/views/user/user_Home/user_Home_controller.dart';
import 'package:flutter_demo/presentation/views/user/user_home/user_home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userHomeProvider = StateNotifierProvider.autoDispose<UserHomeController, UserHomeState>(
  (ref) {
    return UserHomeController();
  }
);

final userHomeIsActiveUrlProvider = StateProvider.autoDispose<bool?>((ref) => null);