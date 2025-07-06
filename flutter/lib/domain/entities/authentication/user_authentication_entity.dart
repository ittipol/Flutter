import 'package:flutter_demo/data/models/authentication/user_authentication_model.dart';

class UserAuthenticationEntity {

  final String? accessToken;
  final String? refreshToken;

  UserAuthenticationEntity({
    this.accessToken,
    this.refreshToken,
  });

  factory UserAuthenticationEntity.fromModel(UserAuthenticationModel model) => UserAuthenticationEntity(
    accessToken: model.accessToken,
    refreshToken: model.refreshToken,
  );
}