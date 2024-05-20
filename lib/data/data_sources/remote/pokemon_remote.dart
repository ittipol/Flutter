import 'package:dio/dio.dart';
import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/data/data_sources/remote/data_sources/pokemon_remote_datasource.dart';
import 'package:flutter_demo/data/models/pokemon_detail_model.dart';
import 'package:flutter_demo/data/models/pokemon_model.dart';
import 'package:flutter_demo/domain/entities/pokemon_detail_entity.dart';
import 'package:flutter_demo/domain/entities/pokemon_entity.dart';

class PokemonRemote implements PokemonRemoteDataSources {

  final Dio dio;

  PokemonRemote({required this.dio});

  @override
  Future<Result<PokemonEntity>> getPokemonIndex({required int offset, required int limit}) async {
    
    try {
      var urlPath = "/api/v2/pokemon";
      
      final dioResponse = await dio.get(
        urlPath,
        queryParameters: {
          "offset": offset,
          "limit": limit
        }
      );

      var model = PokemonModel.fromJson(dioResponse.data);
      var data = PokemonEntity.fromModel(model);

      return ResultSuccess(data: data);
    } on DioException catch (error) {
      return ResultError(exception: error);
    } on Exception catch (error) {
      return ResultError(exception: error);
    }

  }

  @override
  Future<Result<PokemonDetailEntity>> getPokemonDetail({required String name}) async {
    try {
      var urlPath = "/api/v2/pokemon/$name";
      
      final dioResponse = await dio.get(
        urlPath
      );

      var model = PokemonDetailModel.fromJson(dioResponse.data);
      var data = PokemonDetailEntity.fromModel(model);

      return ResultSuccess(data: data);
    } on DioException catch (error) {
      return ResultError(exception: error);
    } on Exception catch (error) {
      return ResultError(exception: error);
    }
  }
}