import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/data/data_sources/local/data_sources/data_storage_local_data_source.dart';
import 'package:flutter_demo/domain/entities/local_storage/data_storage_entity.dart';
import 'package:flutter_demo/domain/repositories/data_storage_repository.dart';

class DataStorageRepositoryImpl implements DataStorageRepository {

  final DataStorageLocalDataSources dataStorageLocalDataSources;

  DataStorageRepositoryImpl({
    required this.dataStorageLocalDataSources
  });

  @override
  Future<Result<DataStorageEntity>> getData() async {
    return await dataStorageLocalDataSources.getData();
  }

  @override
  Future<Result<bool>> saveData(DataStorageEntity value) async {
    return await dataStorageLocalDataSources.saveData(value);
  }

  @override
  Future<Result<bool>> deleteData() async {
    return await dataStorageLocalDataSources.deleteData();
  }

}