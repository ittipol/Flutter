import 'package:flutter_demo/data/app/user_profile.dart';
import 'package:flutter_demo/domain/repositories/user_profile_repository.dart';
import 'package:flutter_demo/presentation/common/blank_page/material_app_blank_widget/material_app_blank_widget.dart';
import 'package:flutter_demo/presentation/common/user_avatar/user_avatar_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileHelper {

  static Future<bool> getUserProfile({required UserProfileRepository userProfileRepository}) async {
    var result = await userProfileRepository.profile();   

    if(result.isCompleted) {
      UserProfile.name = result.getData?.name ?? "";
      if(baseContext.currentContext != null) {
        var parentRef = ProviderScope.containerOf(baseContext.currentContext!);
        parentRef.read(userAvatarProvider.notifier).update(name: UserProfile.name);
      }

      return true;
    }

    return false; 
  }
}