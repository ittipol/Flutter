import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/data/app/user_profile.dart';
import 'package:flutter_demo/data/request/user_login_request.dart';
import 'package:flutter_demo/domain/entities/profile/user_profile_entity.dart';
import 'package:flutter_demo/domain/repositories/authentication_repository.dart';
import 'package:flutter_demo/domain/repositories/data_storage_repository.dart';
import 'package:flutter_demo/domain/repositories/user_profile_repository.dart';
import 'package:flutter_demo/helper/authentication_helper.dart';
import 'package:flutter_demo/helper/user_profile_helper.dart';
import 'package:flutter_demo/presentation/views/user/user_login/user_login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserLoginController extends StateNotifier<UserLoginState> {

  final AuthenticationRepository authenticationRepository;
  final DataStorageRepository dataStorageRepository;
  final UserProfileRepository userProfileRepository;

  UserLoginController({
    required this.authenticationRepository,
    required this.dataStorageRepository,
    required this.userProfileRepository
  }) : super(UserLoginState()); 

  Future<bool> login({required String email, required String password}) async {

    // final cancelToken = CancelToken();
    final request = UserLoginRequest(
      email: email,
      password: password
    );

    return await AuthenticationHelper.login(authenticationRepository: authenticationRepository, request: request, dataStorageRepository: dataStorageRepository);
  }

  Future<bool> profile() async {

    // var result = await userProfileRepository.profile();   

    // if(result.isCompleted) {
    //   UserProfile.name = result.getData?.name ?? "";      
    // } 

    return UserProfileHelper.getUserProfile(userProfileRepository: userProfileRepository);
  }

}