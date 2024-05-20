import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/data/data_sources/remote/data_sources/pokemon_remote_datasource.dart';
import 'package:flutter_demo/domain/entities/pokemon_detail_entity.dart';
import 'package:flutter_demo/domain/entities/pokemon_entity.dart';
import 'package:flutter_demo/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {

  final PokemonRemoteDataSources pokemonRemoteDataSources;

  PokemonRepositoryImpl({
    required this.pokemonRemoteDataSources
  });

  @override
  Future<Result<PokemonEntity>> getPokemonIndex({required int offset, required int limit}) async {
    return pokemonRemoteDataSources.getPokemonIndex(offset: offset, limit: limit);
  }

  @override
  Future<Result<PokemonDetailEntity>> getPokemonDetail({required String name}) async {
    return pokemonRemoteDataSources.getPokemonDetail(name: name);
  }

}