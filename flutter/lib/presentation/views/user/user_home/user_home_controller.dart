import 'package:flutter_demo/data/app/authentication.dart';
import 'package:flutter_demo/domain/repositories/data_storage_repository.dart';
import 'package:flutter_demo/helper/authentication_helper.dart';
import 'package:flutter_demo/presentation/views/user/user_home/user_home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserHomeController extends StateNotifier<UserHomeState> {

  final DataStorageRepository dataStorageRepository;

  UserHomeController({
    required this.dataStorageRepository,
  }) : super(UserHomeState(
    isLoggedIn: Authentication.isLoggedIn
  ));

  void update({required bool isLoggedIn}) {
    state = state.copyWith(isLoggedIn: isLoggedIn);
  }  

  Future<bool> logout() async {
    return await AuthenticationHelper.logout(dataStorageRepository: dataStorageRepository, callBack: (result) {
      if(result) {
        // logout success
        state = state.copyWith(isLoggedIn: false);
      }                      
    });
  }

}