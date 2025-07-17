class TestEcdhModel {
  final String? serverPrivateKey;
  final String? serverPublicKey;
  final String? serverSharedKey;

  TestEcdhModel({
    this.serverPrivateKey,
    this.serverPublicKey,
    this.serverSharedKey
  });

  factory TestEcdhModel.fromJson(Map<String, dynamic> json) => TestEcdhModel(
    serverPrivateKey: json["serverPrivateKey"],
    serverPublicKey: json["serverPublicKey"],
    serverSharedKey: json["serverSharedKey"],
  );

}