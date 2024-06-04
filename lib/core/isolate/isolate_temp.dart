import 'dart:async';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DeletetionEvent {}

class ReadEvent<T> {
  final T data;
  const ReadEvent(this.data);
}

class IsolateSuccess<T> {
  final T data;
  const IsolateSuccess(this.data);
}

class ReadResult {
  final String key;
  final String? content;
  const ReadResult(this.key, this.content);
}

class IsolateIO {
  IsolateIO._();

  final _toBgPort = Completer();
  final Map<Object, Completer> _completerMap = {};

  Isolate? _isolate;
  StreamSubscription? _fromBgListener;

  void start() async {
    RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    ReceivePort fromBG = ReceivePort();

    _fromBgListener = fromBG.listen((message) {
      // setup process
      if (message is SendPort) {
        _toBgPort.complete(message);
        return;
      }

      if (message is ReadResult) {
        _completerMap['read:${message.key}']?.complete(message.content);
        _completerMap.remove('read:${message.key}');
      }
    });

    // _isolate = await Isolate.spawn(
    //   (CreationEvent data) {
    //     final worker = IsolateWorker2(data.isolateToken, data.sendPort);
    //     worker.listen();
    //   },
    //   CreationEvent(rootIsolateToken, fromBG.sendPort),
    // );
  }

  Future<String?> readFromStorage(String key) async {
    // make sure isolate created with ports
    final port = await _toBgPort.future;

    // store completer
    final completer = Completer<String?>();
    _completerMap['read:$key'] = completer;

    // send key to be read
    port.send(ReadEvent(key));

    // return result
    return completer.future;
  }

  void stop() async {
    if (_toBgPort.isCompleted) {
      final port = await _toBgPort.future;
      port.send(DeletetionEvent());
    }
    _fromBgListener?.cancel();
    _isolate?.kill(priority: Isolate.immediate);
  }

  static final i = IsolateIO._();
}

class IsolateWorker2 {
  final RootIsolateToken rootIsolateToken;
  final SendPort toMain;
  final FlutterSecureStorage storage;

  StreamSubscription? subs;

  IsolateWorker2(
    this.rootIsolateToken,
    this.toMain, {
    this.storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    ),
  }) {
    // Register the background isolate with the root isolate.
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
  }

  void listen() {
    ReceivePort fromMain = ReceivePort();
    toMain.send(fromMain.sendPort);
    subs = fromMain.listen((message) => onMessage(message));
  }

  void onMessage(dynamic message) async {
    if (message is DeletetionEvent) {
      subs?.cancel();
      return;
    }

    if (message is ReadEvent) {
      final rawJson = await storage.read(key: message.data);
      toMain.send(ReadResult(message.data, rawJson));
    }
  }
}

class View extends StatefulWidget {
  const View({super.key});

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  String username = '';
  @override
  void initState() {
    super.initState();
    IsolateIO.i.start();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final name = await IsolateIO.i.readFromStorage('username');
      setState(() {
        username = name ?? '';
      });
    });
  }

  @override
  void dispose() {
    IsolateIO.i.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(username),
    );
  }
}

class CompleterString {
  static Completer<String>? completer;
}