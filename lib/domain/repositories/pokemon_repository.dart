import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/domain/entities/pokemon/pokemon_detail_entity.dart';
import 'package:flutter_demo/domain/entities/pokemon/pokemon_entity.dart';

abstract class PokemonRepository {

  Future<Result<PokemonEntity>> getPokemonIndex({required int offset, required int limit});
  Future<Result<PokemonDetailEntity>> getPokemonDetail({required String name});
  
}