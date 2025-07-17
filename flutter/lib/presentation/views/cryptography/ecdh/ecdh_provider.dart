import 'package:flutter_demo/config/network/dio_option.dart';
import 'package:flutter_demo/data/app/api_base_url.dart';
import 'package:flutter_demo/data/data_sources/remote/key_exchange_remote.dart';
import 'package:flutter_demo/data/repositories/key_exchange_repository_.impl.dart';
import 'package:flutter_demo/presentation/views/cryptography/ecdh/ecdh_controller.dart';
import 'package:flutter_demo/presentation/views/cryptography/ecdh/ecdh_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ecdhProvider = StateNotifierProvider.autoDispose<EcdhController, EcdhState>(
  (ref) => EcdhController(
    keyExchangeRepository: KeyExchangeRepositoryImpl(
      keyExchangeRemoteDataSources: KeyExchangeRemote(dio: DioOption().init(baseUrl: ApiBaseUrl.localhostApiBaseUrl))
    )
  )
);