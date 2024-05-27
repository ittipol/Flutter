class PokemonFavoriteEntity {
  final int? id;
  final String? name;

  PokemonFavoriteEntity({
    this.id,
    this.name
  });

  factory PokemonFavoriteEntity.fromJson(Map<String, dynamic> json) => PokemonFavoriteEntity(
    id: json["id"],
    name: json["name"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name
  };
}