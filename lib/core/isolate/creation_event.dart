import 'dart:isolate';
import 'dart:ui';

class CreationEvent {
  final RootIsolateToken isolateToken;
  final SendPort sendPort;

  CreationEvent({
    required this.isolateToken,
    required this.sendPort
  });
}