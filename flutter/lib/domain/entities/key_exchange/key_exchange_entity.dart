import 'package:flutter_demo/data/models/key_exchange/key_exchange_model.dart';

class KeyExchangeEntity {
  final String? publicKey;
  final String? encryptedKeyData;
  final String? sharedKey;

  KeyExchangeEntity({
    this.publicKey,
    this.encryptedKeyData,
    this.sharedKey
  });

  factory KeyExchangeEntity.fromModel(KeyExchangeModel model) => KeyExchangeEntity(
    publicKey: model.publicKey,
    encryptedKeyData: model.encryptedKeyData,
    sharedKey: model.sharedKey
  );
}