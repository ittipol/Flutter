import 'dart:async';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:flutter_demo/core/isolate/deletion_event.dart';
import 'package:flutter_demo/core/isolate/read_event.dart';
import 'package:flutter_demo/core/isolate/read_result.dart';

class IsolateWorker {
  final RootIsolateToken rootIsolateToken;
  final SendPort toMain;

  StreamSubscription? subs;

  IsolateWorker(
    this.rootIsolateToken,
    this.toMain, 
  ) {
    // Register the background isolate with the root isolate.
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
  }

  void listen<R, T>({required FutureOr<R> Function(T)? onData}) {
    ReceivePort fromMain = ReceivePort();
    toMain.send(fromMain.sendPort);
    subs = fromMain.listen((event) async {
      if (event is ReadEvent<T>) {
        final data = await onData!(event.data);
        toMain.send(ReadResult(data));
        return;
      }

      if (event is DeletionEvent) {
        subs?.cancel();
        fromMain.close();
        return;
      }      
    });
  }
}