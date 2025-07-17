class KeyExchangeModel {
  final String? publicKey;
  final String? encryptedKeyData;
  final String? sharedKey;

  KeyExchangeModel({
    this.publicKey,
    this.encryptedKeyData,
    this.sharedKey
  });

  factory KeyExchangeModel.fromJson(Map<String, dynamic> json) => KeyExchangeModel(
    publicKey: json["publicKey"],
    encryptedKeyData: json["encryptedKeyData"],
    sharedKey: json["sharedKey"],
  );

}