import 'package:flutter_demo/data/models/pokemon/pokemon_sprites_model.dart';
import 'package:flutter_demo/data/models/pokemon/pokemon_type_model.dart';

class PokemonDetailModel {
  final int? id;
  final int? height;
  final int? weight;
  final String? name;
  final PokemonSpriteModel? sprites;
  final List<PokemonTypesModel>? types;

  PokemonDetailModel({
    this.id,
    this.height,
    this.weight,
    this.name,
    this.sprites,
    this.types
  });

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) => PokemonDetailModel(
    id: json["id"],
    height: json["height"],
    weight: json["weight"],
    name: json["name"],
    sprites: json["sprites"] == null ? null : PokemonSpriteModel.fromJson(json["sprites"]),
    types: json["types"] == null ? [] : List<PokemonTypesModel>.from(json["types"]!.map((x) => PokemonTypesModel.fromJson(x))),
  );

}