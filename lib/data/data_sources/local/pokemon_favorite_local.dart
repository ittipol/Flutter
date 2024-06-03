import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/core/errors/local_storage_exception.dart';
import 'package:flutter_demo/data/data_sources/local/data_sources/pokemon_favorite_local_data_source.dart';
import 'package:flutter_demo/domain/entities/local_storage/pokemon_favorite_entity.dart';
import 'package:flutter_demo/utils/utils.dart';
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
      var data = await storage.read(key: _storageKey) ?? "";

      if(data.isEmpty) {
        return ResultError(exception: LocalStorageException(
          message: "Not Found",
          type: LocalStorageExceptionType.notFound
        ));
      }

      return await compute<String, Result<List<PokemonFavoriteEntity>>>((data) async {        

        var entity = Utils.jsonDeserialize<List<PokemonFavoriteEntity>, List<dynamic>>(data, (json) {
          return List<PokemonFavoriteEntity>.from(json.map((value) => PokemonFavoriteEntity.fromJson(value)));
        });

        return ResultSuccess<List<PokemonFavoriteEntity>>(data: entity);
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
      var json = await compute((message) {    
        return jsonEncode(message);        
      }, list);

      await storage.write(key: _storageKey, value: json);          
      return const ResultSuccess<bool>(data: true);
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
      await storage.delete(key: _storageKey);
      
      return const ResultSuccess<bool>(data: true);
    }catch(e){
      return ResultError(exception: LocalStorageException(
        message: e.toString(),
        type: LocalStorageExceptionType.failure
      ));
    }
  }
}