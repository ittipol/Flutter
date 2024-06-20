import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_demo/core/constant/api_end_point_constant.dart';
import 'package:flutter_demo/data/data_sources/remote/pokemon_remote.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pokemon_remote_test.mocks.dart';

@GenerateMocks([Dio])
void main() {  

  group('Pokemon remote test', () {
    late MockDio mockDio;
    late PokemonRemote pokemonRemote;

    setUp(() {
      mockDio = MockDio();
      pokemonRemote = PokemonRemote(dio: mockDio);
    });

    test("Given limit and offset as parameter when API is called then response Pokemon list", () async {

      const limit = 20;
      const offset = 0;

      when(mockDio.get(
        ApiEndPointConstant.getPokemons,
        queryParameters: {
          "offset": offset,
          "limit": limit
        }
      )).thenAnswer((_) async {
        return Response(
          requestOptions: RequestOptions(),
          statusCode: HttpStatus.ok,
          data: {"count":20}
        );
      });

      final result = await pokemonRemote.getPokemonIndex(
        limit: limit,
        offset: offset
      );

      final value = result.when(
        completeWithValue: (value) {
          return value.data.count;
        },
        completeWithError: (error) {
          return 0;
        },
      );

      expect(result.isCompleted, true);
      expect(value, limit);

    });

    test("Given limit and offset as parameter when API is called then response an error", () async {

      const limit = 20;
      const offset = 0;

      when(mockDio.get(
        ApiEndPointConstant.getPokemons,
        queryParameters: {
          "offset": offset,
          "limit": limit
        }
      )).thenThrow(DioException(
        requestOptions: RequestOptions(),
        response: Response(requestOptions: RequestOptions(), statusCode: HttpStatus.badRequest)
      ));

      final result = await pokemonRemote.getPokemonIndex(
        limit: limit,
        offset: offset
      );

      final value = result.when(
        completeWithValue: (value) {
          return null;
        },
        completeWithError: (error) {
          return error.httpStatusCode;
        },
      );

      expect(result.isCompleted, false);
      expect(value, HttpStatus.badRequest);

    });

    test("Given Pokemon name as parameter when API is called then response Pokemon detail", () async {

      const name = "pikachu";

      when(mockDio.get(
        "${ApiEndPointConstant.getPokemons}/$name"
      )).thenAnswer((_) async {
        return Response(
          requestOptions: RequestOptions(),
          statusCode: HttpStatus.ok,
          data: {"name":"pikachu"}
        );
      });

      final result = await pokemonRemote.getPokemonDetail(name: name);

      expect(result.isCompleted, true);

    });

    test("Given Pokemon name as parameter when API is called then response an error", () async {

      const name = "pikachu";

      when(mockDio.get(
        "${ApiEndPointConstant.getPokemons}/$name"
      )).thenThrow(DioException(
        requestOptions: RequestOptions(),
        response: Response(requestOptions: RequestOptions(), statusCode: HttpStatus.internalServerError)
      ));

      final result = await pokemonRemote.getPokemonDetail(name: name);

      final value = result.when(
        completeWithValue: (value) {
          return null;
        },
        completeWithError: (error) {
          return error.httpStatusCode;
        },
      );

      expect(result.isCompleted, false);
      expect(value, HttpStatus.internalServerError);

    });

  });  

}