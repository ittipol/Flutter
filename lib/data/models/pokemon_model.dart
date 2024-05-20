import 'package:flutter_demo/data/models/pokemon_result_model.dart';

class PokemonModel {

  final int? count;
  final String? next;
  final String? previous;
  final List<PokemonResultModel>? results;

  PokemonModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) => PokemonModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: json["results"] == null ? [] : List<PokemonResultModel>.from(json["results"]!.map((x) => PokemonResultModel.fromJson(x))),
  );
}