import 'package:elliptic/elliptic.dart';
import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/domain/entities/key_exchange/key_exchange_entity.dart';
import 'package:flutter_demo/domain/entities/key_exchange/test_ecdh_entity.dart';
import 'package:flutter_demo/domain/repositories/key_exchange_repository.dart';
import 'package:flutter_demo/presentation/views/cryptography/ecdh/ecdh_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EcdhController extends StateNotifier<EcdhState> {

  final KeyExchangeRepository keyExchangeRepository;

  EcdhController({
    required this.keyExchangeRepository,
  }) : super(EcdhState());

  void updateData({PrivateKey? privateKey, PublicKey? publicKey, List<int>? sharedSecretKey, PublicKey? otherPartyPublicKey, String? cipherText}) {
    state = state.copyWith(
      privateKey: privateKey,
      publicKey: publicKey,
      sharedSecretKey: sharedSecretKey,
      otherPartyPublicKey: otherPartyPublicKey,
      cipherText: cipherText
    );
  }

  Future<Result<KeyExchangeEntity>> keyExchange(String publicKey) async {
    return await keyExchangeRepository.exchange(publicKey);
  }

  Future<Result<TestEcdhEntity>> TestEcdh(String privateKey, String publicKey) async {
    return await keyExchangeRepository.TestEcdh(privateKey, publicKey);
  }

}