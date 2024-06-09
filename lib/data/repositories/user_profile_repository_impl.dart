import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/data/data_sources/remote/data_sources/user_profile_remote_data_source.dart';
import 'package:flutter_demo/domain/entities/profile/user_profile_entity.dart';
import 'package:flutter_demo/domain/repositories/user_profile_repository.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {

  final UserProfileRemoteDataSources userProfileRemoteDataSources;

  UserProfileRepositoryImpl({
    required this.userProfileRemoteDataSources
  });

  @override
  Future<Result<UserProfileEntity>> profile() async {
    return await userProfileRemoteDataSources.profile();
  }

}