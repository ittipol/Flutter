import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_demo/core/isolate/creation_event.dart';
import 'package:flutter_demo/core/isolate/isolate_temp.dart';
import 'package:flutter_demo/domain/entities/local_storage/data_storage_entity.dart';

class IsolateBuild {

  Future<String> readFromStorage(void Function(CreationEvent) entryPoint, String key) async {
    final toMainPort = Completer<SendPort>();
    final completer = Completer<String>();

    await _compute<String>(entryPoint, toMainPort, completer);

    var port = await toMainPort.future;
    port.send(ReadEvent(key));

    return completer.future;
  }

  Future<bool> saveToStorage(void Function(CreationEvent) entryPoint, DataStorageEntity value) async {
    final toMainPort = Completer<SendPort>();
    final completer = Completer<bool>();

    await _compute<bool>(entryPoint, toMainPort, completer);

    var port = await toMainPort.future;
    port.send(ReadEvent(value));

    return completer.future;
  }

  Future<R> compute<R, T>(void Function(CreationEvent) entryPoint, T data) async {
    final toMainPort = Completer<SendPort>();
    final completer = Completer<R>();

    await _compute<R>(entryPoint, toMainPort, completer);

    var port = await toMainPort.future;
    port.send(ReadEvent(data));

    return completer.future;
  }

  Future<void> _compute<T>(void Function(CreationEvent) entryPoint, Completer<SendPort> toMainPort, Completer<T> completer) async {

    RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    ReceivePort main = ReceivePort();   

    main.listen((message) {

      // Set up
      if (message is SendPort) {
        debugPrint("######### [setup process]------> ${message.toString()}");
        toMainPort.complete(message);
        return;
      }

      // Return success or error
      // if(message is IsolateSuccess) {}
      // if(message is IsolateError) {}

      if(message is ReadResult) {
        debugPrint("######### [ReadResult Result]------> [ ${message.content} ]"); 

        dynamic content = message.content;

        completer.complete(content ?? "");
        return;
      }

      if(message is String) {
        debugPrint("######### [String Result]------> [ $message ]"); 
        completer.complete(message as dynamic);
        return;
      }

      if(message is DataStorageEntity) {
        debugPrint("######### [DataStorageEntity Result]------> [ ${message.name} ]"); 
        completer.complete(message as dynamic);
        return;
      }
    });

    await Isolate.spawn(entryPoint, CreationEvent(
      isolateToken: rootIsolateToken,
      sendPort: main.sendPort
    ));    
  }

}