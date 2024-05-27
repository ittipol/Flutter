import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/domain/entities/local_storagea/data_storage_entity.dart';

abstract class DataStorageRepository {
  Future<Result<DataStorageEntity>> getData();
  Future<Result<bool>> saveData(DataStorageEntity value);
  Future<Result<bool>> deleteData();
}