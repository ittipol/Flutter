import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/core/errors/local_storage_exception.dart';
import 'package:flutter_demo/data/data_sources/local/data_sources/data_storage_local_data_source.dart';
import 'package:flutter_demo/domain/entities/local_storage/data_storage_entity.dart';
import 'package:flutter_demo/utils/utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataStorageLocal implements DataStorageLocalDataSources {

  final FlutterSecureStorage storage;
  final String _storageKey = 'local_storage_key';  

  DataStorageLocal({
    this.storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      )
    )
  });

  @override
  Future<Result<DataStorageEntity>> getData() async {

    try {            
      var data = await storage.read(key: _storageKey) ?? "";

      if(data.isEmpty) {
        return ResultError(exception: LocalStorageException(
          message: "Not Found",
          type: LocalStorageExceptionType.notFound
        ));
      }

      return await compute<String, Result<DataStorageEntity>>((data) async {        
        var entity = Utils.jsonDeserialize<DataStorageEntity, Map<String, dynamic>>(data, (json) {
          return DataStorageEntity.fromJson(json);
        });

        return ResultSuccess<DataStorageEntity>(data: entity);
      }, data);   

    } catch (e) {
      return ResultError(exception: LocalStorageException(
        message: e.toString(),
        type: LocalStorageExceptionType.failure
      ));
    }
  }

  @override
  Future<Result<bool>> saveData(DataStorageEntity value) async {
    try{      
      var json = await compute((message) async {    
        return jsonEncode(message);        
      }, value);

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