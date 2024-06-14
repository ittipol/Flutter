import 'package:dio/dio.dart';
import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/core/constant/api_end_point_constant.dart';
import 'package:flutter_demo/data/data_sources/remote/data_sources/user_profile_remote_data_source.dart';
import 'package:flutter_demo/data/models/profile/user_profile_model.dart';
import 'package:flutter_demo/domain/entities/profile/user_profile_entity.dart';

class UserProfileRemote implements UserProfileRemoteDataSources {
  final Dio dio;

  UserProfileRemote({required this.dio});

  @override
  Future<Result<UserProfileEntity>> profile() async {
    try {
      final dioResponse = await dio.get(ApiEndPointConstant.userProfile);

      var model = UserProfileModel.fromJson(dioResponse.data);
      var data = UserProfileEntity.fromModel(model);

      return ResultComplete(data: data);
    } on DioException catch (error) {
      return ResultError(exception: error, httpStatusCode: error.response?.statusCode);
    } on Exception catch (error) {
      return ResultError(exception: error);
    }    
  }

}