import 'package:flutter_demo/data/models/pokemon_detail_model.dart';
import 'package:flutter_demo/data/models/pokemon_sprites_model.dart';
import 'package:flutter_demo/domain/entities/pokemon_detail_sprite_entity.dart';
import 'package:flutter_demo/domain/entities/pokemon_detail_types_entity.dart';

class PokemonDetailEntity {

  final int? id;
  final int? height;
  final int? weight;
  final String? name;
  final PokemonDetailSpriteEntity? sprites;
  final List<PokemonDetailTypesEntity>? types;

  PokemonDetailEntity({
    this.id,
    this.height,
    this.weight,
    this.name,
    this.sprites,
    this.types
  });

  factory PokemonDetailEntity.fromModel(PokemonDetailModel model) => PokemonDetailEntity(
    id: model.id,
    height: model.height,
    weight: model.weight,
    name: model.name,
    sprites: PokemonDetailSpriteEntity.fromModel(model.sprites ?? PokemonSpriteModel()),
    types: List<PokemonDetailTypesEntity>.from(model.types!.map((x) => PokemonDetailTypesEntity.fromModel(x)))
  );

}