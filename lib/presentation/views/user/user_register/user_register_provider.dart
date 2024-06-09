import 'package:flutter_demo/config/network/dio_option.dart';
import 'package:flutter_demo/data/data_sources/remote/user_register_remote.dart';
import 'package:flutter_demo/data/repositories/user_register_repository_impl.dart';
import 'package:flutter_demo/presentation/views/user/user_register/user_register_controller.dart';
import 'package:flutter_demo/presentation/views/user/user_register/user_register_state.dart';
import 'package:flutter_demo/setting/app_api_url_setting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRegisterProvider = StateNotifierProvider.autoDispose<UserRegisterController, UserRegisterState>(
  (ref) {
    return UserRegisterController(
      userRegisterRepository: UserRegisterRepositoryImpl(
        userRegisterRemoteDataSources: UserRegisterRemote(dio: DioOption().init(baseUrl: AppApiUrlSetting.localHostUrl))
      )
    );
  }
);

final userRegisterEmailErrorTextProvider = StateProvider.autoDispose<String?>((ref) => null);