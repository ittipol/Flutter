import 'package:flutter_demo/data/models/authentication/token_verify_model.dart';

class TokenVerifyEntity {

  final String? message;

  TokenVerifyEntity({
    this.message
  });

  factory TokenVerifyEntity.fromModel(TokenVerifyModel model) => TokenVerifyEntity(
    message: model.message
  );
}