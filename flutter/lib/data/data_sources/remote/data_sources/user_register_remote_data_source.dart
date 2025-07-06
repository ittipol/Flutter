import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/data/request/user_register_request.dart';
import 'package:flutter_demo/domain/entities/register/user_register_entity.dart';

abstract class UserRegisterRemoteDataSources {
  Future<Result<UserRegisterEntity>> register(UserRegisterRequest request);
}