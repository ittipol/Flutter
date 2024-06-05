import 'dart:isolate';

import 'package:flutter/services.dart';

class SimpleIsolate {
  static Future<T> compute<T>(T Function() function) async {
    final receivePort = ReceivePort();
    final rootToken = RootIsolateToken.instance!;
    
    var isolate = await Isolate.spawn<SimpleIsolateData>(
      _isolateEntry,
      SimpleIsolateData<T>(
        token: rootToken,
        function: function,
        answerPort: receivePort.sendPort,
      ),
    );
    var data = await receivePort.first;

    isolate.kill(priority: Isolate.immediate);
    receivePort.close();

    return data;
  }

  static void _isolateEntry(SimpleIsolateData isolateData) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(isolateData.token);
    final answer = await isolateData.function();
    isolateData.answerPort.send(answer);
  }
}

class SimpleIsolateData<T> {
  final RootIsolateToken token;
  final T Function() function;
  final SendPort answerPort;

  SimpleIsolateData({
    required this.token,
    required this.function,
    required this.answerPort,
  });
}