import 'package:flutter_demo/data/models/pokemon_sprites_model.dart';

class PokemonDetailSpriteEntity {
  final PokemonSpriteOtherEntity? other;

  PokemonDetailSpriteEntity({
    this.other,
  });

  factory PokemonDetailSpriteEntity.fromModel(PokemonSpriteModel model) => PokemonDetailSpriteEntity(
    other: PokemonSpriteOtherEntity.fromModel(model.other ?? PokemonSpriteOtherModel()),
  );

}

class PokemonSpriteOtherEntity {

  final PokemonOfficialArtworkEntity? officialArtwork;

  PokemonSpriteOtherEntity({
    this.officialArtwork
  });

  factory PokemonSpriteOtherEntity.fromModel(PokemonSpriteOtherModel model) => PokemonSpriteOtherEntity(
    officialArtwork: PokemonOfficialArtworkEntity.fromModel(model.officialArtwork ?? PokemonOfficialArtworkModel()),
  );

}

class PokemonOfficialArtworkEntity {

  final String? frontDefault;
  final String? frontShiny;

  PokemonOfficialArtworkEntity({
    this.frontDefault,
    this.frontShiny
  });

  factory PokemonOfficialArtworkEntity.fromModel(PokemonOfficialArtworkModel model) => PokemonOfficialArtworkEntity(
    frontDefault: model.frontDefault,
    frontShiny: model.frontShiny
  );

}