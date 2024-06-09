import 'package:flutter/foundation.dart';
import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/data/app/authentication.dart';
import 'package:flutter_demo/data/app/user_profile.dart';
import 'package:flutter_demo/data/request/user_login_request.dart';
import 'package:flutter_demo/domain/entities/authentication/user_authentication_entity.dart';
import 'package:flutter_demo/domain/entities/local_storage/data_storage_entity.dart';
import 'package:flutter_demo/domain/entities/profile/user_profile_entity.dart';
import 'package:flutter_demo/domain/repositories/authentication_repository.dart';
import 'package:flutter_demo/domain/repositories/data_storage_repository.dart';
import 'package:flutter_demo/domain/repositories/user_profile_repository.dart';
import 'package:flutter_demo/helper/local_storage_helper.dart';
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

  Future<Result<UserAuthenticationEntity>> login({required String email, required String password}) async {

    // final cancelToken = CancelToken();
    final request = UserLoginRequest(
      email: email,
      password: password
    );

    var result = await authenticationRepository.login(request);

    await Future.delayed(const Duration(milliseconds: 1000));

    if(result.isCompleted) {
      final data = result.getData;

      Authentication.accessToken = data?.accessToken ?? "";
      Authentication.refreshToken = data?.refreshToken ?? "";

      final saveResult = await LocalStorageHelper.saveRefreshToken(refreshToken: Authentication.refreshToken, dataStorageRepository: dataStorageRepository);

      debugPrint("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
      // debugPrint("Authentication.accessToken:: [ ${Authentication.accessToken} ]");
      // debugPrint("Authentication.refreshToken:: [ ${Authentication.refreshToken} ]");
      debugPrint("saveResult:: [ $saveResult ]");
      debugPrint("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    }
    
    return result;
  }

  Future<Result<UserProfileEntity>> profile() async {

    var result = await userProfileRepository.profile();   

    if(result.isCompleted) {
      UserProfile.name = result.getData?.name ?? "";
    } 

    return result;
  }

}