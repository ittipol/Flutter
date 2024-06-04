// import 'dart:isolate';
// import 'dart:ui';

// import 'package:flutter_demo/core/isolate/creation_event.dart';
// import 'package:flutter_demo/core/isolate/isolate_temp.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// abstract class IsolateContext {
//   CreationEvent setMessage();
//   void onData(dynamic message, SendPort toMain);
// }

// class IsolateLocalStorage implements IsolateContext {

//   FlutterSecureStorage storage;

  // IsolateLocalStorage({
  //   this.storage = const FlutterSecureStorage(
  //     aOptions: AndroidOptions(
  //       encryptedSharedPreferences: true,
  //     )
  //   )
  // });

//   @override
//   CreationEvent setMessage() {
//     RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
//     ReceivePort main = ReceivePort();

//     return CreationLocalStorageEvent(
//       isolateToken: rootIsolateToken,
//       sendPort: main.sendPort,
//       storage: storage
//     );
//   }

//   @override
//   void onData(dynamic message, SendPort toMain) async {
//     if (message is ReadEvent) {
//       final rawJson = await storage.read(key: message.key);
//       toMain.send(ReadResult(message.key, rawJson));
//     }
//   }

// }