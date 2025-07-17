import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/domain/entities/key_exchange/key_exchange_entity.dart';
import 'package:flutter_demo/domain/entities/key_exchange/test_ecdh_entity.dart';

abstract class KeyExchangeRepository {

  Future<Result<KeyExchangeEntity>> exchange(String publicKey);
  Future<Result<TestEcdhEntity>> TestEcdh(String privateKey, String publicKey);
  
}