import 'package:flutter_demo/data/data_sources/local/data_storage_local.dart';
import 'package:flutter_demo/data/repositories/data_storage_repository_impl.dart';
import 'package:flutter_demo/presentation/common/user_avatar/user_avatar_controller.dart';
import 'package:flutter_demo/presentation/common/user_avatar/user_avatar_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userAvatarProvider = StateNotifierProvider<UserAvatarController, UserAvatarState>(
  (ref) {
    return UserAvatarController(
      dataStorageRepository: DataStorageRepositoryImpl(
        dataStorageLocalDataSources: DataStorageLocal()
      )
    );
  }
);