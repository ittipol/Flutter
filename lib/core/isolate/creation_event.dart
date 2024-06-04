import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

class CreationEvent<R, T> {
  final RootIsolateToken isolateToken;
  final SendPort sendPort;
  final FutureOr<R> Function(T)? onData;

  CreationEvent({
    required this.isolateToken,
    required this.sendPort,
    this.onData
  });
}