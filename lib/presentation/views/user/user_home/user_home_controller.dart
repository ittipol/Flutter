import 'package:flutter_demo/data/app/authentication.dart';
import 'package:flutter_demo/presentation/views/user/user_home/user_home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserHomeController extends StateNotifier<UserHomeState> {

  UserHomeController() : super(UserHomeState(
    isLoggedIn: Authentication.isLoggedIn
  ));

  void update({required bool isLoggedIn}) {
    state = state.copyWith(isLoggedIn: isLoggedIn);
  }  

}