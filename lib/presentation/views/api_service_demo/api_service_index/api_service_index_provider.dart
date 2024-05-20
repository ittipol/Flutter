import 'package:flutter_demo/config/network/dio_option.dart';
import 'package:flutter_demo/data/data_sources/remote/pokemon_remote.dart';
import 'package:flutter_demo/data/repositories/pokemon_repository_impl.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_index/api_service_index_controller.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_index/api_service_index_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceIndexProvider = StateNotifierProvider.autoDispose<ApiServiceIndexController, ApiServiceIndexState>(
  (ref) => ApiServiceIndexController(
    pokemonRepository: PokemonRepositoryImpl(
      pokemonRemoteDataSources: PokemonRemote(dio: DioOption().init())
    )
  )
);