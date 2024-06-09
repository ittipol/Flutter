import 'package:flutter_demo/domain/entities/pokemon/pokemon_detail_entity.dart';

enum ApiServiceDetailStateStatus { loading, success, failure }

class ApiServiceDetailState {
  final ApiServiceDetailStateStatus status;
  final PokemonDetailEntity? pokemonDetail;

  ApiServiceDetailState({
    this.status = ApiServiceDetailStateStatus.loading,
    this.pokemonDetail
  });

  copyWith({ApiServiceDetailStateStatus? status, PokemonDetailEntity? pokemonDetail}) => ApiServiceDetailState(
    status: status ?? this.status,
    pokemonDetail: pokemonDetail ?? this.pokemonDetail
  );
}