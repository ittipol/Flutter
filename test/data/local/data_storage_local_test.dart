import 'dart:convert';

import 'package:flutter_demo/core/errors/local_storage_exception.dart';
import 'package:flutter_demo/data/data_sources/local/data_storage_local.dart';
import 'package:flutter_demo/domain/entities/local_storage/data_storage_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'data_storage_local_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {

  group('Local storage', () {

    late MockFlutterSecureStorage mockFlutterSecureStorage;
    late DataStorageLocal dataStorageLocal;

    setUp(() {
      mockFlutterSecureStorage = MockFlutterSecureStorage();
      dataStorageLocal = DataStorageLocal(storage: mockFlutterSecureStorage);
    });

    test("Given storage key when read data success then response data from storage", () async {

      const String key = 'local_storage_key';

      when(mockFlutterSecureStorage.read(key: key)).thenAnswer((_) async {
        return "";
      });

      final result = await dataStorageLocal.getData();

      expect(result.isCompleted, true);

    });

    test("Given storage key when read data fail then throw a Exception", () async {

      const String key = 'local_storage_key';

      var type = LocalStorageExceptionType.none;

      when(mockFlutterSecureStorage.read(key: key)).thenThrow(Exception());

      final result = await dataStorageLocal.getData();

      result.when(
        completeWithValue: (value) {
          
        },
        completeWithError: (error) {
          if(error.exception is LocalStorageException) {
            type = (error.exception as LocalStorageException).type;
          }
        }
      );

      expect(result.isCompleted, false);
      expect(type, LocalStorageExceptionType.failure);

    });

    test("Given storage key and data when write data success then response success", () async {

      const String key = 'local_storage_key';
      final data = DataStorageEntity(
        name: "Test",
        refreshToken: "refresh_token"
      );

      final json = jsonEncode(data);

      when(mockFlutterSecureStorage.write(key: key, value: json)).thenAnswer((_) async {
        return Future.value();
      });      

      final result = await dataStorageLocal.saveData(data);

      expect(result.isCompleted, true);

    });

    test("Given storage key and data when write data fail then throw a Exception", () async {

      const String key = 'local_storage_key';      
      final data = DataStorageEntity(
        name: "Test",
        refreshToken: "refresh_token"
      );

      var type = LocalStorageExceptionType.none;

      final json = jsonEncode(data);

      when(mockFlutterSecureStorage.write(key: key, value: json)).thenThrow(Exception());

      final result = await dataStorageLocal.saveData(data);

      result.when(
        completeWithValue: (value) {
          
        },
        completeWithError: (error) {
          if(error.exception is LocalStorageException) {
            type = (error.exception as LocalStorageException).type;
          }
        }
      );

      expect(result.isCompleted, false);
      expect(type, LocalStorageExceptionType.failure);

    });

    test("Given storage key and data when delete data success then response success", () async {

      const String key = 'local_storage_key';

      when(mockFlutterSecureStorage.delete(key: key)).thenAnswer((_) async {
        return Future.value();
      });      

      final result = await dataStorageLocal.deleteData();

      expect(result.isCompleted, true);

    });

    test("Given storage key and data when delete data fail then throw a Exception", () async {

      const String key = 'local_storage_key';
      
      var type = LocalStorageExceptionType.none;

      when(mockFlutterSecureStorage.delete(key: key)).thenThrow(Exception());

      final result = await dataStorageLocal.deleteData();

      result.when(
        completeWithValue: (value) {
          
        },
        completeWithError: (error) {
          if(error.exception is LocalStorageException) {
            type = (error.exception as LocalStorageException).type;
          }
        }
      );

      expect(result.isCompleted, false);
      expect(type, LocalStorageExceptionType.failure);

    });

  });

}