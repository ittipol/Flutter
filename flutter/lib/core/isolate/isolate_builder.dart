import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_demo/core/isolate/creation_event.dart';
import 'package:flutter_demo/core/isolate/deletion_event.dart';
import 'package:flutter_demo/core/isolate/isolate_worker.dart';
import 'package:flutter_demo/core/isolate/read_event.dart';
import 'package:flutter_demo/core/isolate/read_result.dart';

class IsolateBuilder {

  final _bgIsolatePort = ReceivePort();
  final _toBgIsolateCompleter = Completer<SendPort>();
  Isolate? _isolate;
  StreamSubscription? _fromBgListener;

  Future<R> compute<R, T>(FutureOr<R> Function(T)? onData, T data) async {
    
    final completer = Completer<R>();

    await _start<R, T>(onData, completer);

    final port = await _toBgIsolateCompleter.future;
    port.send(ReadEvent(data));

    final value = await completer.future;

    await _stop();

    return value;
  }

  Future<void> _start<R, T>(FutureOr<R> Function(T)? onData, Completer<R> completer) async {

    // Identify the root isolate to pass to the background isolate
    final rootIsolateToken = RootIsolateToken.instance!;

    _fromBgListener = _bgIsolatePort.listen((message) {

      if (message is SendPort) {
        _toBgIsolateCompleter.complete(message);
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
      sendPort: _bgIsolatePort.sendPort,
      onData: onData,
    ));   
  }

  Future<void> _stop() async {
    if (_toBgIsolateCompleter.isCompleted) {
      final port = await _toBgIsolateCompleter.future;
      port.send(DeletionEvent());
    }
    _fromBgListener?.cancel();
    _isolate?.kill(priority: Isolate.immediate);
    _bgIsolatePort.close();
  }
}