import 'package:flutter_demo/domain/entities/pokemon_detail_entity.dart';

enum ApiServiceSearchStateStatus { initial, loading, success, failure }

class ApiServiceSearchState {
  final ApiServiceSearchStateStatus status;
  final PokemonDetailEntity? pokemonDetail;

  ApiServiceSearchState({
    this.status = ApiServiceSearchStateStatus.initial,
    this.pokemonDetail
  });

  copyWith({ApiServiceSearchStateStatus? status, PokemonDetailEntity? pokemonDetail}) => ApiServiceSearchState(
    status: status ?? this.status,
    pokemonDetail: pokemonDetail ?? this.pokemonDetail
  );
}