import 'package:flutter_demo/data/models/pokemon/pokemon_model.dart';
import 'package:flutter_demo/data/models/pokemon/pokemon_result_model.dart';

class PokemonEntity {

  final int? count;
  final String? next;
  final String? previous;
  final List<PokemonResultModel>? results;

  PokemonEntity({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PokemonEntity.fromModel(PokemonModel model) => PokemonEntity(
    count: model.count,
    next: model.next,
    previous: model.previous,
    results: model.results,
  );
}