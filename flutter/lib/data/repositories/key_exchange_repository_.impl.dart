import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/data/data_sources/remote/data_sources/key_exchange_remote_data_source.dart';
import 'package:flutter_demo/domain/entities/key_exchange/key_exchange_entity.dart';
import 'package:flutter_demo/domain/entities/key_exchange/test_ecdh_entity.dart';
import 'package:flutter_demo/domain/repositories/key_exchange_repository.dart';

class KeyExchangeRepositoryImpl implements KeyExchangeRepository {

  final KeyExchangeRemoteDataSources keyExchangeRemoteDataSources;

  KeyExchangeRepositoryImpl({
    required this.keyExchangeRemoteDataSources
  });

  @override
  Future<Result<KeyExchangeEntity>> exchange(String publicKey) async {
    return keyExchangeRemoteDataSources.exchange(publicKey);
  }

  @override
  Future<Result<TestEcdhEntity>> TestEcdh(String privateKey, String publicKey) {
    return keyExchangeRemoteDataSources.TestEcdh(privateKey, publicKey);
  }

}