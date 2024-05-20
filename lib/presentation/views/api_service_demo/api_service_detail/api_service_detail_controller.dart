import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/domain/entities/pokemon_detail_entity.dart';
import 'package:flutter_demo/domain/repositories/pokemon_repository.dart';
import 'package:flutter_demo/presentation/views/api_service_demo/api_service_detail/api_service_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiServiceDetailController extends StateNotifier<ApiServiceDetailState> {

  final PokemonRepository pokemonRepository;

  ApiServiceDetailController({
    required this.pokemonRepository
  }) : super(ApiServiceDetailState());

  Future<Result<PokemonDetailEntity>> getPokemonDetail(String name) async {

    // final cancelToken = CancelToken();
    state = state.copyWith(status: ApiServiceDetailStateStatus.loading);

    var result = await pokemonRepository.getPokemonDetail(name: name);

    await Future.delayed(const Duration(milliseconds: 300));

    if(result is ResultSuccess) {      
      state = state.copyWith(status: ApiServiceDetailStateStatus.success, pokemonDetail: (result as ResultSuccess<PokemonDetailEntity>).data);
    }
    
    return result;
  }

}