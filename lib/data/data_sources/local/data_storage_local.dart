import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/core/errors/local_storage_exception.dart';
import 'package:flutter_demo/core/isolate/isolate_build.dart';
import 'package:flutter_demo/core/isolate/isolate_temp.dart';
import 'package:flutter_demo/core/isolate/isolate_worker.dart';
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
      debugPrint("[Start] !!!!!!!!++++++++++!!!!!!!!++++++++++!!!!!!!!++++++++++!!!!!!!!++++++++++!!!!!!!!++++++++++");

      var isolate = IsolateBuild();

      var data = await isolate.readFromStorage((message) { 
        final worker = IsolateWorker(
          message.isolateToken, 
          message.sendPort
        );

        worker.listen(onData: (event, toMain) async {
          debugPrint("######### [ReadEvent]------> ReadEvent");
          final rawJson = await storage.read(key: event.data);
          toMain.send(ReadResult(event.data, rawJson));      
        });
      }, _storageKey);

      if(data.isEmpty) {
        return ResultError(exception: LocalStorageException(
          message: "Not Found",
          type: LocalStorageExceptionType.notFound
        ));
      }

      // return await compute<String, Result<DataStorageEntity>>((data) async {        
      //   var entity = Utils.jsonDeserialize<DataStorageEntity, Map<String, dynamic>>(data, (json) {
      //     return DataStorageEntity.fromJson(json);
      //   });

      //   return ResultSuccess<DataStorageEntity>(data: entity);
      // }, data);  

      var entity = await isolate.compute<DataStorageEntity, String>((message) {

        final worker = IsolateWorker(
          message.isolateToken, 
          message.sendPort
        );

        worker.listen(onData: (event, toMain) async {
          var entity = Utils.jsonDeserialize<DataStorageEntity, Map<String, dynamic>>(event.data, (json) {
            return DataStorageEntity.fromJson(json);
          });
          toMain.send(entity);
        });
      }, data);

      return ResultSuccess<DataStorageEntity>(data: entity);

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
      // var json = await compute((message) async {    
      //   return jsonEncode(message);        
      // }, value);

      // ======
      var isolate = IsolateBuild();
      var json = await isolate.compute<String, DataStorageEntity>((message) {
        
        final worker = IsolateWorker(
          message.isolateToken, 
          message.sendPort
        );

        worker.listen(onData: (event, toMain) async {
          var json = jsonEncode(event.data);        
          toMain.send(json);
        });

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

  Future<String> readFromStorage(Completer<SendPort> toBgPort, String key) async {
    // make sure isolate created with ports
    final port = await toBgPort.future;

    // store completer
    final completer = Completer<String>();
    // _completerMap['read:$key'] = completer;
    CompleterString.completer = completer;

    // send key to be read
    port.send(ReadEvent(key));

    // completer.complete()

    // Future.delayed(const Duration(seconds: 5), () {
    //   completer.complete('{"name":"ZZZZTTTYYYYY"}');
    // });

    // return result

    // wait for calling `complete` method
    return completer.future;
    // return '{"name":"aaaaaaabbbbbbb"}';
  }
}