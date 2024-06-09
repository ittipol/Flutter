import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/domain/entities/pokemon/pokemon_entity.dart';
import 'package:flutter_demo/domain/repositories/pokemon_repository.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_index/api_service_index_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiServiceIndexController extends StateNotifier<ApiServiceIndexState> {

  final PokemonRepository pokemonRepository;

  ApiServiceIndexController({
    required this.pokemonRepository
  }) : super(ApiServiceIndexState());

  Future<Result<PokemonEntity>> getPokemonIndex({required int offset, required int limit}) async {

    // final cancelToken = CancelToken();
    state = state.copyWith(status: ApiServiceIndexStateStatus.loading);

    var result = await pokemonRepository.getPokemonIndex(offset: offset, limit: limit);

    await Future.delayed(const Duration(milliseconds: 1000));

    // if(result is ResultSuccess) {      
    //   state = state.copyWith(status: ApiServiceIndexStateStatus.success, pokemon: (result as ResultSuccess<PokemonEntity>).data);
    // }

    if(result.isCompleted) {      
      final data = result.getData ?? PokemonEntity();
      state = state.copyWith(status: ApiServiceIndexStateStatus.success, pokemon: data);
    }
    
    return result;
  }

}