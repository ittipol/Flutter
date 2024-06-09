import 'package:flutter_demo/config/network/dio_option.dart';
import 'package:flutter_demo/data/app/user_profile.dart';
import 'package:flutter_demo/data/data_sources/remote/user_profile_remote.dart';
import 'package:flutter_demo/data/repositories/user_profile_repository_impl.dart';
import 'package:flutter_demo/setting/app_api_url_setting.dart';

class UserProfileHelper {

  static Future<void> getUserProfile() async {
    final userProfileRepository = UserProfileRepositoryImpl(
      userProfileRemoteDataSources: UserProfileRemote(dio: DioOption().init(baseUrl: AppApiUrlSetting.localHostUrl))
    );

    var result = await userProfileRepository.profile();   

    if(result.isCompleted) {
      UserProfile.name = result.getData?.name ?? "";
    } 
  }
}