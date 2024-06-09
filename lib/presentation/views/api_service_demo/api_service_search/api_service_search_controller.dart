import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/domain/entities/pokemon/pokemon_detail_entity.dart';
import 'package:flutter_demo/domain/repositories/pokemon_repository.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_search/api_service_search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiServiceSearchController extends StateNotifier<ApiServiceSearchState> {

  final PokemonRepository pokemonRepository;

  ApiServiceSearchController({
    required this.pokemonRepository
  }) : super(ApiServiceSearchState());

  Future<Result<PokemonDetailEntity>> searchPokemon(String name) async {    

    if(name.isEmpty) {
      state = state.copyWith(status: ApiServiceSearchStateStatus.initial);
      return ResultSuccess<PokemonDetailEntity>(
        data: PokemonDetailEntity()
      );
    }

    // final cancelToken = CancelToken();
    state = state.copyWith(status: ApiServiceSearchStateStatus.loading);

    var result = await pokemonRepository.getPokemonDetail(name: name);

    await Future.delayed(const Duration(milliseconds: 300));

    if(result is ResultSuccess) {      
      state = state.copyWith(status: ApiServiceSearchStateStatus.success, pokemonDetail: (result as ResultSuccess<PokemonDetailEntity>).data);
    }else {
      state = state.copyWith(status: ApiServiceSearchStateStatus.failure);
    }
        
    return result;
  }

}