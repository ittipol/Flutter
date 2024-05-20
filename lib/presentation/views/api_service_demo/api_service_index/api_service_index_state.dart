import 'package:flutter_demo/domain/entities/pokemon_entity.dart';

enum ApiServiceIndexStateStatus { loading, success, failure }

class ApiServiceIndexState {
  final ApiServiceIndexStateStatus status;
  final PokemonEntity? pokemon;

  ApiServiceIndexState({
    this.status = ApiServiceIndexStateStatus.loading,
    this.pokemon
  });

  copyWith({ApiServiceIndexStateStatus? status, PokemonEntity? pokemon}) => ApiServiceIndexState(
    status: status ?? this.status,
    pokemon: pokemon ?? this.pokemon
  );
}