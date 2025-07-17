import 'package:flutter_demo/data/models/key_exchange/test_ecdh_model.dart';

class TestEcdhEntity {
  final String? serverPrivateKey;
  final String? serverPublicKey;
  final String? serverSharedKey;

  TestEcdhEntity({
    this.serverPrivateKey,
    this.serverPublicKey,
    this.serverSharedKey
  });

  factory TestEcdhEntity.fromModel(TestEcdhModel model) => TestEcdhEntity(
    serverPrivateKey: model.serverPrivateKey,
    serverPublicKey: model.serverPublicKey,
    serverSharedKey: model.serverSharedKey
  );
}