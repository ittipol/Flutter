import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_demo/core/isolate/creation_event.dart';
import 'package:flutter_demo/core/isolate/deletion_event.dart';
import 'package:flutter_demo/core/isolate/isolate_worker.dart';
import 'package:flutter_demo/core/isolate/read_event.dart';
import 'package:flutter_demo/core/isolate/read_result.dart';

class IsolateBuilder {

  Isolate? _isolate;
  StreamSubscription? _fromBgListener;

  Future<R> compute<R, T>(FutureOr<R> Function(T)? onData, T data) async {
    final toMainPort = Completer<SendPort>();
    final completer = Completer<R>();

    await _start<R, T>(onData, toMainPort, completer);

    var port = await toMainPort.future;
    port.send(ReadEvent(data));

    var value = await completer.future;

    await _stop(toMainPort);

    return value;
  }

  Future<void> _start<R, T>(FutureOr<R> Function(T)? onData, Completer<SendPort> toMainPort, Completer<R> completer) async {

    RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    ReceivePort main = ReceivePort();   

    _fromBgListener = main.listen((message) {

      if (message is SendPort) {
        toMainPort.complete(message);
        return;
      }

      if(message is ReadResult<R>) {
        completer.complete(message.data);
        return;
      }

    });   

    _isolate = await Isolate.spawn((message) {
      
      final worker = IsolateWorker(
        message.isolateToken, 
        message.sendPort
      );
      worker.listen<R, T>(onData: message.onData);

    }, CreationEvent<R, T>(
      isolateToken: rootIsolateToken,
      sendPort: main.sendPort,
      onData: onData,
    ));    
  }

  Future<void> _stop(Completer<SendPort> toMainPort) async {
    if (toMainPort.isCompleted) {
      final port = await toMainPort.future;
      port.send(DeletionEvent());
    }
    _fromBgListener?.cancel();
    _isolate?.kill(priority: Isolate.immediate);
  }

}