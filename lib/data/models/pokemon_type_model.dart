class PokemonTypesModel {
  final PokemonTypeModel? type;

  PokemonTypesModel({
    this.type,
  });

  factory PokemonTypesModel.fromJson(Map<String, dynamic> json) => PokemonTypesModel(
    type: json["type"] == null ? null : PokemonTypeModel.fromJson(json["type"]),
  );

}

class PokemonTypeModel {

  final String? name;

  PokemonTypeModel({
    this.name
  });

  factory PokemonTypeModel.fromJson(Map<String, dynamic> json) => PokemonTypeModel(
    name: json["name"],
  );

}