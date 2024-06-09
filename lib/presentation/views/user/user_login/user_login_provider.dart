import 'package:flutter_demo/config/network/dio_option.dart';
import 'package:flutter_demo/data/data_sources/local/data_storage_local.dart';
import 'package:flutter_demo/data/data_sources/remote/authentication_remote.dart';
import 'package:flutter_demo/data/repositories/authentication_repository_impl.dart';
import 'package:flutter_demo/data/repositories/data_storage_repository_impl.dart';
import 'package:flutter_demo/data/repositories/user_profile_repository_impl.dart';
import 'package:flutter_demo/presentation/views/user/user_login/user_login_controller.dart';
import 'package:flutter_demo/presentation/views/user/user_login/user_login_state.dart';
import 'package:flutter_demo/setting/app_api_url_setting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/data_sources/remote/user_profile_remote.dart';

final userLoginProvider = StateNotifierProvider.autoDispose<UserLoginController, UserLoginState>(
  (ref) {
    return UserLoginController(
      authenticationRepository: AuthenticationRepositoryImpl(
        authenticationRemoteDataSources: AuthenticationRemote(dio: DioOption().init(baseUrl: AppApiUrlSetting.localHostUrl))
      ),
      dataStorageRepository: DataStorageRepositoryImpl(
        dataStorageLocalDataSources: DataStorageLocal()
      ),
      userProfileRepository: UserProfileRepositoryImpl(
        userProfileRemoteDataSources: UserProfileRemote(dio: DioOption().init(baseUrl: AppApiUrlSetting.localHostUrl))
      )
    );
  }
);

final userLoginEmailErrorTextProvider = StateProvider.autoDispose<String?>((ref) => null);