import 'package:flutter_demo/data/data_sources/local/data_storage_local.dart';
import 'package:flutter_demo/data/repositories/data_storage_repository_impl.dart';
import 'package:flutter_demo/presentation/views/local_storage_demo/local_storage_demo_controller.dart';
import 'package:flutter_demo/presentation/views/local_storage_demo/local_storage_demo_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageDemoProvider = StateNotifierProvider.autoDispose<LocalStorageDemoController, LocalStorageDemoState>(
  (ref) => LocalStorageDemoController(
    dataStorageRepository: DataStorageRepositoryImpl(
      dataStorageLocalDataSources: DataStorageLocal()
    )
  ),  
);