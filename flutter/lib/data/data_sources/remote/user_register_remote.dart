import 'package:dio/dio.dart';
import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/core/constant/api_end_point_constant.dart';
import 'package:flutter_demo/data/data_sources/remote/data_sources/user_register_remote_data_source.dart';
import 'package:flutter_demo/data/models/register/user_register_model.dart';
import 'package:flutter_demo/data/request/user_register_request.dart';
import 'package:flutter_demo/domain/entities/register/user_register_entity.dart';

class UserRegisterRemote implements UserRegisterRemoteDataSources {
  final Dio dio;

  UserRegisterRemote({required this.dio});

  @override
  Future<Result<UserRegisterEntity>> register(UserRegisterRequest request) async {       
    try {
      final dioResponse = await dio.post(ApiEndPointConstant.userRegister, data: request.toJson());

      var model = UserRegisterModel.fromJson(dioResponse.data);
      var data = UserRegisterEntity.fromModel(model);

      return ResultComplete(data: data);
    } on DioException catch (error) {
      return ResultError(exception: error, httpStatusCode: error.response?.statusCode);
    } on Exception catch (error) {
      return ResultError(exception: error);
    }
  }

}