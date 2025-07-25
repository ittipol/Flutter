import 'package:elliptic/elliptic.dart';

class EcdhState{
  final PrivateKey? privateKey;
  final PublicKey? publicKey;
  final List<int>? sharedSecretKey;
  final PublicKey? otherPartyPublicKey;
  final String? cipherText;
  final String? keyId;
  
  EcdhState({
    this.privateKey,
    this.publicKey,
    this.sharedSecretKey,
    this.otherPartyPublicKey,
    this.cipherText,
    this.keyId
  });

  copyWith({PrivateKey? privateKey, PublicKey? publicKey, List<int>? sharedSecretKey, PublicKey? otherPartyPublicKey, String? cipherText, String? keyId}) => EcdhState(
    privateKey: privateKey ?? this.privateKey,
    publicKey: publicKey ?? this.publicKey,
    sharedSecretKey: sharedSecretKey ?? this.sharedSecretKey,
    otherPartyPublicKey: otherPartyPublicKey ?? this.otherPartyPublicKey,
    cipherText: cipherText ?? this.cipherText,
    keyId: keyId ?? this.keyId
  );
}