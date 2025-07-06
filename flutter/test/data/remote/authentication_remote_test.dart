
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_demo/core/constant/api_end_point_constant.dart';
import 'package:flutter_demo/data/data_sources/remote/authentication_remote.dart';
import 'package:flutter_demo/data/request/user_login_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authentication_remote_test.mocks.dart';

@GenerateMocks([Dio])
void main() {  

  group('Authentication remote test [Log in]', () {

    late MockDio mockDio;
    late AuthenticationRemote authenticationRemote;

    setUp(() {
      mockDio = MockDio();
      authenticationRemote = AuthenticationRemote(dio: mockDio);
    });

    test("Given email and password when request success then response access token and refresh token", () async {

      var accessToken = "";
      var refreshToken = "";

      final request = UserLoginRequest(
        email: "test@mail.com",
        password: "1234"
      );

      final responsePayload = {
        "accessToken" : "access_token",
        "refreshToken" : "refresh_token"
      };

      when(mockDio.post(
        ApiEndPointConstant.login,
        data: request.toJson()
      )).thenAnswer((_) async {
        return Response(
          requestOptions: RequestOptions(),
          statusCode: HttpStatus.ok,
          data: responsePayload
        );
      });

      final result = await authenticationRemote.login(request);

      result.when(
        completeWithValue: (value) {
          accessToken = value.data.accessToken ?? "";
          refreshToken = value.data.refreshToken ?? "";
        },
        completeWithError: (error) {
          
        }
      );

      expect(result.isCompleted, true);
      expect(accessToken, responsePayload["accessToken"]);
      expect(refreshToken, responsePayload["refreshToken"]);

    });

    test("Given email and password when request fail then throw a DioException", () async {
      
      final request = UserLoginRequest(
        email: "test@mail.com",
        password: "1234"
      );

      when(mockDio.post(
        ApiEndPointConstant.login,
        data: request.toJson()
      )).thenThrow(DioException(
        requestOptions: RequestOptions(),
        response: Response(requestOptions: RequestOptions(), statusCode: HttpStatus.unauthorized)
      ));

      final result = await authenticationRemote.login(request);

      final value = result.when(
        completeWithValue: (value) {
          return null;
        },
        completeWithError: (error) {
          return error.httpStatusCode;
        },
      );

      expect(result.isCompleted, false);
      expect(value, HttpStatus.unauthorized);

    });    

    test("Given email and password when request fail then throw a Exception", () async {
      
      final request = UserLoginRequest(
        email: "test@mail.com",
        password: "1234"
      );

      when(mockDio.post(
        ApiEndPointConstant.login,
        data: request.toJson()
      )).thenThrow(Exception());

      final result = await authenticationRemote.login(request);

      expect(result.isCompleted, false);

    });    

  });  
}