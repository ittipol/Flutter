import 'dart:convert';

import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/core/errors/local_storage_exception.dart';
import 'package:flutter_demo/core/isolate/isolate_builder.dart';
import 'package:flutter_demo/data/data_sources/local/data_sources/pokemon_favorite_local_data_source.dart';
import 'package:flutter_demo/domain/entities/local_storage/pokemon_favorite_entity.dart';
import 'package:flutter_demo/helper/helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PokemonFavoriteLocal implements PokemonFavoriteLocalDataSources {

  final FlutterSecureStorage storage;
  final String _storageKey = 'pokemon_favorite_key';

  PokemonFavoriteLocal({
    this.storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      )
    )
  });

  @override
  Future<Result<List<PokemonFavoriteEntity>>> getData() async {

    try {            
      
      final isolate = IsolateBuilder();
      var data = await isolate.compute((message) async {
        return await storage.read(key: _storageKey) ?? "";
      }, _storageKey);

      if(data.isEmpty) {
        return ResultError(exception: LocalStorageException(
          message: "Not Found",
          type: LocalStorageExceptionType.notFound
        ));
      }

      return await isolate.compute((message) async {
        var entity = Helper.jsonDeserialize<List<PokemonFavoriteEntity>, List<dynamic>>(data, (json) {
          return List<PokemonFavoriteEntity>.from(json.map((value) => PokemonFavoriteEntity.fromJson(value)));
        });

        return ResultComplete<List<PokemonFavoriteEntity>>(data: entity);
      }, data);

    } catch (e) {
      return ResultError(exception: LocalStorageException(
        message: e.toString(),
        type: LocalStorageExceptionType.failure
      ));
    }
  }

  @override
  Future<Result<bool>> saveData(List<PokemonFavoriteEntity> list) async {
    try{      

      final isolate = IsolateBuilder();
      var json = await isolate.compute((message) async {
        return jsonEncode(message);
      }, list);

      return await isolate.compute((message) async {
        await storage.write(key: message[0], value: message[1]);
        return const ResultComplete<bool>(data: true);
      }, [_storageKey, json]);

    }catch(e){
      return ResultError(exception: LocalStorageException(
        message: e.toString(),
        type: LocalStorageExceptionType.failure
      ));
    }
  }

  @override
  Future<Result<bool>> deleteData() async {
    try{      

      final isolate = IsolateBuilder();
      return await isolate.compute((message) async {
        await storage.delete(key: _storageKey);
        return const ResultComplete<bool>(data: true);
      }, _storageKey);

    }catch(e){
      return ResultError(exception: LocalStorageException(
        message: e.toString(),
        type: LocalStorageExceptionType.failure
      ));
    }
  }
}