import 'package:elliptic/elliptic.dart';

class EcdhState{
  final PrivateKey? privateKey;
  final PublicKey? publicKey;
  final List<int>? sharedSecretKey;
  final PublicKey? otherPartyPublicKey;
  final String? cipherText;
  
  EcdhState({
    this.privateKey,
    this.publicKey,
    this.sharedSecretKey,
    this.otherPartyPublicKey,
    this.cipherText
  });

  copyWith({PrivateKey? privateKey, PublicKey? publicKey, List<int>? sharedSecretKey, PublicKey? otherPartyPublicKey, String? cipherText}) => EcdhState(
    privateKey: privateKey ?? this.privateKey,
    publicKey: publicKey ?? this.publicKey,
    sharedSecretKey: sharedSecretKey ?? this.sharedSecretKey,
    otherPartyPublicKey: otherPartyPublicKey ?? this.otherPartyPublicKey,
    cipherText: cipherText ?? this.cipherText
  );
}