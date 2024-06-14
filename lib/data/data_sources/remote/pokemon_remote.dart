import 'package:dio/dio.dart';
import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/core/constant/api_end_point_constant.dart';
import 'package:flutter_demo/data/data_sources/remote/data_sources/pokemon_remote_data_source.dart';
import 'package:flutter_demo/data/models/pokemon/pokemon_detail_model.dart';
import 'package:flutter_demo/data/models/pokemon/pokemon_model.dart';
import 'package:flutter_demo/domain/entities/pokemon/pokemon_detail_entity.dart';
import 'package:flutter_demo/domain/entities/pokemon/pokemon_entity.dart';

class PokemonRemote implements PokemonRemoteDataSources {

  final Dio dio;

  PokemonRemote({required this.dio});

  @override
  Future<Result<PokemonEntity>> getPokemonIndex({required int offset, required int limit}) async {
    
    try {

      final dioResponse = await dio.get(
        ApiEndPointConstant.getPokemons,
        queryParameters: {
          "offset": offset,
          "limit": limit
        }
      );

      var model = PokemonModel.fromJson(dioResponse.data);
      var data = PokemonEntity.fromModel(model);

      return ResultComplete(data: data);
    } on DioException catch (error) {
      return ResultError(exception: error, httpStatusCode: error.response?.statusCode);
    } on Exception catch (error) {
      return ResultError(exception: error);
    }
  }

  @override
  Future<Result<PokemonDetailEntity>> getPokemonDetail({required String name}) async {
    try {          

      final dioResponse = await dio.get("${ApiEndPointConstant.getPokemons}/$name");

      var model = PokemonDetailModel.fromJson(dioResponse.data);
      var data = PokemonDetailEntity.fromModel(model);

      return ResultComplete(data: data);
    } on DioException catch (error) {
      return ResultError(exception: error, httpStatusCode: error.response?.statusCode);
    } on Exception catch (error) {
      return ResultError(exception: error);
    }
  }
}