import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/domain/entities/local_storagea/pokemon_favorite_entity.dart';

abstract class PokemonFavoriteLocalDataSources{
  Future<Result<List<PokemonFavoriteEntity>>> getData();
  Future<Result<bool>> saveData(List<PokemonFavoriteEntity> value);
  Future<Result<bool>> deleteData();

}