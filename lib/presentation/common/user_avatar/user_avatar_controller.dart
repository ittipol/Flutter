import 'package:flutter_demo/data/app/authentication.dart';
import 'package:flutter_demo/domain/repositories/data_storage_repository.dart';
import 'package:flutter_demo/helper/authentication_helper.dart';
import 'package:flutter_demo/presentation/common/user_avatar/user_avatar_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAvatarController extends StateNotifier<UserAvatarState> {

  final DataStorageRepository dataStorageRepository;

  UserAvatarController({
    required this.dataStorageRepository,
  }) : super(UserAvatarState(
    isLoggedIn: Authentication.isLoggedIn
  ));

  void update({String? name, bool? isLoggedIn}) {
    state = state.copyWith(name: name, isLoggedIn: isLoggedIn);
  }

  void authentication() {
    state = state.copyWith(isLoggedIn: true);
  }  

  void guest() {
    state = state.copyWith(isLoggedIn: false);
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