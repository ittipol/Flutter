import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/core/constant/api_end_point_constant.dart';
import 'package:flutter_demo/data/data_sources/remote/data_sources/key_exchange_remote_data_source.dart';
import 'package:flutter_demo/data/models/key_exchange/key_exchange_model.dart';
import 'package:flutter_demo/data/models/key_exchange/test_ecdh_model.dart';
import 'package:flutter_demo/domain/entities/key_exchange/key_exchange_entity.dart';
import 'package:flutter_demo/domain/entities/key_exchange/test_ecdh_entity.dart';

class KeyExchangeRemote implements KeyExchangeRemoteDataSources {
  final Dio dio;

  KeyExchangeRemote({required this.dio});

  @override
  Future<Result<KeyExchangeEntity>> exchange(String publicKey) async {
    try {
      dio.options.baseUrl = "http://localhost:5026";
      Map<String, dynamic> headers = {"public-key": publicKey};
      dio.options.headers.addAll(headers);

      // body
      Map<String, dynamic> json = {
        "data1": "aaa",
        "data2": "bbb"
      }; // send request body as json

      String jsonString = jsonEncode(json); // send request body as string

      final dioResponse = await dio.post(ApiEndPointConstant.keyExchange, data: json);

      // var response = jsonDecode(dioResponse.data.toString()) as Map<String, dynamic>;
      // var model = KeyExchangeModel.fromJson(response);

      var model = KeyExchangeModel.fromJson(dioResponse.data);
      var data = KeyExchangeEntity.fromModel(model);

      return ResultComplete(data: data);
    } on DioException catch (error) {
      return ResultError(exception: error, httpStatusCode: error.response?.statusCode);
    } on Exception catch (error) {
      return ResultError(exception: error);
    }
  }

  // @override
  // Future<Result<TestEcdhEntity>> testEcdh(String privateKey, String publicKey) async {
  //   try {
  //     dio.options.baseUrl = "http://localhost:5026";
  //     Map<String, dynamic> headers = {"public-key": publicKey, "private-key": privateKey};
  //     dio.options.headers.addAll(headers);

  //     final dioResponse = await dio.post(ApiEndPointConstant.TestEcdh);

  //     var response = jsonDecode(dioResponse.data.toString()) as Map<String, dynamic>;

  //     var model = TestEcdhModel.fromJson(response);
  //     var data = TestEcdhEntity.fromModel(model);

  //     return ResultComplete(data: data);
  //   } on DioException catch (error) {
  //     return ResultError(exception: error, httpStatusCode: error.response?.statusCode);
  //   } on Exception catch (error) {
  //     return ResultError(exception: error);
  //   }
  // }

  @override
  Future<Result<TestEcdhEntity>> testEcdh(String privateKey, String publicKey) async {
    try {
      dio.options.baseUrl = "http://localhost:5026";
      Map<String, dynamic> headers = {"key-id": privateKey};
      dio.options.headers.addAll(headers);

      final dioResponse = await dio.get(ApiEndPointConstant.health);

      var response = jsonDecode(dioResponse.data.toString()) as Map<String, dynamic>;

      var model = TestEcdhModel.fromJson(response);
      var data = TestEcdhEntity.fromModel(model);

      return ResultComplete(data: data);
    } on DioException catch (error) {
      return ResultError(exception: error, httpStatusCode: error.response?.statusCode);
    } on Exception catch (error) {
      return ResultError(exception: error);
    }
  }

  @override
  Future<Result<TestEcdhEntity>> testSendData(String keyId) async {
    try {
      dio.options.baseUrl = "http://localhost:5026";
      Map<String, dynamic> headers = {"key-id": keyId}; // key id --> use dio intercept
      dio.options.headers.addAll(headers);

      Map<String, dynamic> mapData = {
        "firstName": "aaa",
        "lastName": "bbb"
      };

      // final dioResponse = await dio.get(ApiEndPointConstant.json);
      final dioResponse = await dio.post(ApiEndPointConstant.json, data: mapData); // encryption --> use dio intercept

      var response = jsonDecode(dioResponse.data.toString()) as Map<String, dynamic>;

      var model = TestEcdhModel.fromJson(response);
      var data = TestEcdhEntity.fromModel(model);

      return ResultComplete(data: data);
    } on DioException catch (error) {
      return ResultError(exception: error, httpStatusCode: error.response?.statusCode);
    } on Exception catch (error) {
      return ResultError(exception: error);
    }
  }

}