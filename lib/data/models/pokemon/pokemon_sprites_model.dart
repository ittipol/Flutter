class PokemonSpriteModel {
  final PokemonSpriteOtherModel? other;

  PokemonSpriteModel({
    this.other,
  });

  factory PokemonSpriteModel.fromJson(Map<String, dynamic> json) => PokemonSpriteModel(
    other: json["other"] == null ? null : PokemonSpriteOtherModel.fromJson(json["other"]),
  );

}

class PokemonSpriteOtherModel {

  final PokemonOfficialArtworkModel? officialArtwork;

  PokemonSpriteOtherModel({
    this.officialArtwork
  });

  factory PokemonSpriteOtherModel.fromJson(Map<String, dynamic> json) => PokemonSpriteOtherModel(
    officialArtwork: json["official-artwork"] == null ? null : PokemonOfficialArtworkModel.fromJson(json["official-artwork"]),
  );

}

class PokemonOfficialArtworkModel {

  final String? frontDefault;
  final String? frontShiny;

  PokemonOfficialArtworkModel({
    this.frontDefault,
    this.frontShiny
  });

  factory PokemonOfficialArtworkModel.fromJson(Map<String, dynamic> json) => PokemonOfficialArtworkModel(
    frontDefault: json["front_default"],
    frontShiny: json["front_shiny"],
  );

}