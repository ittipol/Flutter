import 'dart:async';
import 'dart:convert';

import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/core/errors/local_storage_exception.dart';
import 'package:flutter_demo/core/isolate/isolate_builder.dart';
import 'package:flutter_demo/data/data_sources/local/data_sources/data_storage_local_data_source.dart';
import 'package:flutter_demo/domain/entities/local_storage/data_storage_entity.dart';
import 'package:flutter_demo/helper/helper.dart';
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

    final isolate = IsolateBuilder();
    return await isolate.compute((message) async {

      try {      

        var json = await storage.read(key: message) ?? "";

        if(json.isEmpty) {
          return ResultError(exception: LocalStorageException(
            message: "Not Found",
            type: LocalStorageExceptionType.notFound
          ));
        }

        var entity = Helper.jsonDeserialize<DataStorageEntity, Map<String, dynamic>>(json, (json) {
          return DataStorageEntity.fromJson(json);
        });

        return ResultSuccess<DataStorageEntity>(data: entity);      

      } catch (e) {
        return ResultError(exception: LocalStorageException(
          message: e.toString(),
          type: LocalStorageExceptionType.failure
        ));
      }

    }, _storageKey);
    
  }

  @override
  Future<Result<bool>> saveData(DataStorageEntity value) async {

    final isolate = IsolateBuilder();    
    return await isolate.compute((message) async {

      try{  
        var json = jsonEncode(message[1] as DataStorageEntity);

        await storage.write(key: message[0] as String, value: json);
        return const ResultSuccess<bool>(data: true);

      }catch(e){
        return ResultError(exception: LocalStorageException(
          message: e.toString(),
          type: LocalStorageExceptionType.failure
        ));
      }

    }, [_storageKey, value]);

  }

  @override
  Future<Result<bool>> deleteData() async {

    final isolate = IsolateBuilder();
    return await isolate.compute((message) async {

      try{            

        await storage.delete(key: message);
        return const ResultSuccess<bool>(data: true);

      }catch(e){
        return ResultError(exception: LocalStorageException(
          message: e.toString(),
          type: LocalStorageExceptionType.failure
        ));
      }

    }, _storageKey);
    
  }
}