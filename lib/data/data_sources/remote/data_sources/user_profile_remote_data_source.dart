import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/domain/entities/profile/user_profile_entity.dart';

abstract class UserProfileRemoteDataSources {
  Future<Result<UserProfileEntity>> profile();
}