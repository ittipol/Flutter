import 'package:flutter_demo/data/models/pokemon_type_model.dart';

class PokemonDetailTypesEntity {
  final PokemonTypeEntity? type;

  PokemonDetailTypesEntity({
    this.type,
  });

  factory PokemonDetailTypesEntity.fromModel(PokemonTypesModel model) => PokemonDetailTypesEntity(
    type: PokemonTypeEntity.fromModel(model.type ?? PokemonTypeModel()),
  );

}

class PokemonTypeEntity {

  final String? name;

  PokemonTypeEntity({
    this.name
  });

  factory PokemonTypeEntity.fromModel(PokemonTypeModel model) => PokemonTypeEntity(
    name: model.name,
  );

}