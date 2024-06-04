import 'dart:async';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:flutter_demo/core/isolate/isolate_temp.dart';

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

  void listen({required void Function(ReadEvent, SendPort) onData}) {
    ReceivePort fromMain = ReceivePort();
    toMain.send(fromMain.sendPort);
    subs = fromMain.listen((event) {
      if (event is ReadEvent) {
        onData(event, toMain);
      }
    });
  }

  // void onProcess(dynamic message) async {
  //   if (message is DeletionEvent) {
  //     subs?.cancel();
  //     return;
  //   }

  //   if (message is ReadEvent) {
  //     final rawJson = await storage.read(key: message.key);
  //     toMain.send(ReadResult(message.key, rawJson));
  //   }
  // }
}