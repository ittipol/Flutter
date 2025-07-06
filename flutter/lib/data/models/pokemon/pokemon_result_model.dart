class PokemonResultModel {

  final String? name;
  final String? url;

  PokemonResultModel({
    this.name,
    this.url,
  });

  factory PokemonResultModel.fromJson(Map<String, dynamic> json) => PokemonResultModel(
    name: json["name"],
    url: json["url"],
  );
}