import 'package:flutter_demo/config/network/result.dart';
import 'package:flutter_demo/domain/entities/local_storagea/data_storage_entity.dart';
import 'package:flutter_demo/domain/repositories/data_storage_repository.dart';
import 'package:flutter_demo/presentation/views/local_storage_demo/local_storage_demo_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalStorageDemoController extends StateNotifier<LocalStorageDemoState> {

  final DataStorageRepository dataStorageRepository;

  LocalStorageDemoController({
    required this.dataStorageRepository
  }) : super(LocalStorageDemoState());  

  void updateText(String name) {
    state = state.copyWith(name: name);
  }

  Future<DataStorageEntity> getData() async {
    var result = await dataStorageRepository.getData();

    if(result.isCompleted) {
      var entity = result as ResultSuccess<DataStorageEntity>;

      state = state.copyWith(name: entity.data.name);

      return entity.data;
    }

    return DataStorageEntity();
  }

  Future<void> saveData(String name) async {
    if(name.isEmpty) {
      return;
    }

    var data = DataStorageEntity(
      name: name
    );

    var result = await dataStorageRepository.saveData(data);

    if(result.isCompleted) {
      state = state.copyWith(name: name);
    }
  }

  Future<void> deleteData() async {
    var result = await dataStorageRepository.deleteData();

    if(result.isCompleted) {
      state = state.copyWith(name: "");
    }
  }

}