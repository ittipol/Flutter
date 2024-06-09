import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/data/data_sources/remote/data_sources/user_register_remote_data_source.dart';
import 'package:flutter_demo/data/request/user_register_request.dart';
import 'package:flutter_demo/domain/entities/register/user_register_entity.dart';
import 'package:flutter_demo/domain/repositories/user_register_repository.dart';

class UserRegisterRepositoryImpl implements UserRegisterRepository {

  final UserRegisterRemoteDataSources userRegisterRemoteDataSources;

  UserRegisterRepositoryImpl({
    required this.userRegisterRemoteDataSources
  });

  @override
  Future<Result<UserRegisterEntity>> register(UserRegisterRequest request) async {
    return await userRegisterRemoteDataSources.register(request);
  }

}