import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/data/data_sources/remote/data_sources/authentication_remote_data_source.dart';
import 'package:flutter_demo/data/request/user_login_request.dart';
import 'package:flutter_demo/domain/entities/authentication/token_verify_entity.dart';
import 'package:flutter_demo/domain/entities/authentication/user_authentication_entity.dart';
import 'package:flutter_demo/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {

  final AuthenticationRemoteDataSources authenticationRemoteDataSources;

  AuthenticationRepositoryImpl({
    required this.authenticationRemoteDataSources
  });

  @override
  Future<Result<UserAuthenticationEntity>> login(UserLoginRequest request) async {
    return await authenticationRemoteDataSources.login(request);
  }

  @override
  Future<Result<UserAuthenticationEntity>> refresh() async {
    return await authenticationRemoteDataSources.refresh();
  }

  @override
  Future<Result<TokenVerifyEntity>> verify() async {
    return await authenticationRemoteDataSources.verify();
  }
}