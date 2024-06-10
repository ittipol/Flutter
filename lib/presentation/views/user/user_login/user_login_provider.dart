import 'package:flutter_demo/config/network/dio_option.dart';
import 'package:flutter_demo/data/app/api_base_url.dart';
import 'package:flutter_demo/data/data_sources/local/data_storage_local.dart';
import 'package:flutter_demo/data/data_sources/remote/authentication_remote.dart';
import 'package:flutter_demo/data/data_sources/remote/user_profile_remote.dart';
import 'package:flutter_demo/data/repositories/authentication_repository_impl.dart';
import 'package:flutter_demo/data/repositories/data_storage_repository_impl.dart';
import 'package:flutter_demo/data/repositories/user_profile_repository_impl.dart';
import 'package:flutter_demo/presentation/views/user/user_login/user_login_controller.dart';
import 'package:flutter_demo/presentation/views/user/user_login/user_login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userLoginProvider = StateNotifierProvider.autoDispose<UserLoginController, UserLoginState>(
  (ref) {
    return UserLoginController(
      authenticationRepository: AuthenticationRepositoryImpl(
        authenticationRemoteDataSources: AuthenticationRemote(dio: DioOption().init(baseUrl: ApiBaseUrl.localhostBaseUrl))
      ),
      dataStorageRepository: DataStorageRepositoryImpl(
        dataStorageLocalDataSources: DataStorageLocal()
      ),
      userProfileRepository: UserProfileRepositoryImpl(
        userProfileRemoteDataSources: UserProfileRemote(dio: DioOption().init(baseUrl: ApiBaseUrl.localhostBaseUrl))
      )
    );
  }
);

final userLoginEmailErrorTextProvider = StateProvider.autoDispose<String?>((ref) => null);