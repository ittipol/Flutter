import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/data/request/user_login_request.dart';
import 'package:flutter_demo/domain/entities/authentication/token_verify_entity.dart';
import 'package:flutter_demo/domain/entities/authentication/user_authentication_entity.dart';

abstract class AuthenticationRemoteDataSources {
  Future<Result<UserAuthenticationEntity>> login(UserLoginRequest request);
  Future<Result<UserAuthenticationEntity>> refresh();
  Future<Result<TokenVerifyEntity>> verify();
}