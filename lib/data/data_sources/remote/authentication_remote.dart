import 'package:dio/dio.dart';
import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/core/constant/api_end_point_constant.dart';
import 'package:flutter_demo/core/isolate/isolate_builder.dart';
import 'package:flutter_demo/data/app/authentication.dart';
import 'package:flutter_demo/data/data_sources/remote/data_sources/authentication_remote_data_source.dart';
import 'package:flutter_demo/data/models/authentication/token_verify_model.dart';
import 'package:flutter_demo/data/models/authentication/user_authentication_model.dart';
import 'package:flutter_demo/data/request/user_login_request.dart';
import 'package:flutter_demo/domain/entities/authentication/token_verify_entity.dart';
import 'package:flutter_demo/domain/entities/authentication/user_authentication_entity.dart';

class AuthenticationRemote implements AuthenticationRemoteDataSources {
  final Dio dio;

  AuthenticationRemote({required this.dio});

  @override
  Future<Result<UserAuthenticationEntity>> login(UserLoginRequest request) async {

    final isolate = IsolateBuilder();
    return await isolate.compute((message) async {
      try {
        final dioResponse = await dio.post(ApiEndPointConstant.login, data: request.toJson());

        var model = UserAuthenticationModel.fromJson(dioResponse.data);
        var data = UserAuthenticationEntity.fromModel(model);

        return ResultSuccess(data: data);
      } on DioException catch (error) {
        return ResultError(exception: error);
      } on Exception catch (error) {
        return ResultError(exception: error);
      }
    }, request);
    
  }

  @override
  Future<Result<UserAuthenticationEntity>> refresh() async {

    // final isolate = IsolateBuilder();
    // return await isolate.compute((message) async {
    //   try {
    //     final dioResponse = await dio.post(
    //       urlPath,
    //       options: Options(
    //         headers: {
    //           "Authorization": "Bearer ${Authentication.refreshToken}"
    //         }
    //       )
    //     );

    //     var model = UserAuthenticationModel.fromJson(dioResponse.data);
    //     var data = UserAuthenticationEntity.fromModel(model);

    //     return ResultSuccess(data: data);
    //   } on DioException catch (error) {
    //     return ResultError(exception: error);
    //   } on Exception catch (error) {
    //     return ResultError(exception: error);
    //   }
    // }, "");

    try {
      final dioResponse = await dio.post(
        ApiEndPointConstant.refreshToken,
        options: Options(
          headers: {
            "Authorization": "Bearer ${Authentication.refreshToken}"
          }
        )
      );

      var model = UserAuthenticationModel.fromJson(dioResponse.data);
      var data = UserAuthenticationEntity.fromModel(model);

      return ResultSuccess(data: data);
    } on DioException catch (error) {
      return ResultError(exception: error);
    } on Exception catch (error) {
      return ResultError(exception: error);
    }

  }

  @override
  Future<Result<TokenVerifyEntity>> verify() async {

    // final isolate = IsolateBuilder();
    // return await isolate.compute((message) async {
    //   try {
    //     final dioResponse = await dio.post(urlPath);

    //     var model = TokenVerifyModel.fromJson(dioResponse.data);
    //     var data = TokenVerifyEntity.fromModel(model);

    //     return ResultSuccess(data: data);
    //   } on DioException catch (error) {
    //     return ResultError(exception: error);
    //   } on Exception catch (error) {
    //     return ResultError(exception: error);
    //   }
    // }, "");

    try {
      final dioResponse = await dio.post(ApiEndPointConstant.verify);

      var model = TokenVerifyModel.fromJson(dioResponse.data);
      var data = TokenVerifyEntity.fromModel(model);

      return ResultSuccess(data: data);
    } on DioException catch (error) {
      return ResultError(exception: error);
    } on Exception catch (error) {
      return ResultError(exception: error);
    }

  }
}