import 'package:flutter_demo/config/network/dio_option.dart';
import 'package:flutter_demo/data/data_sources/remote/pokemon_remote.dart';
import 'package:flutter_demo/data/repositories/pokemon_repository_impl.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_search/api_service_search_controller.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_search/api_service_search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceSearchProvider = StateNotifierProvider.autoDispose<ApiServiceSearchController, ApiServiceSearchState>(
  (ref) => ApiServiceSearchController(
    pokemonRepository: PokemonRepositoryImpl(
      pokemonRemoteDataSources: PokemonRemote(dio: DioOption().init())
    )
  )
);