import 'package:flutter_demo/data/models/register/user_register_model.dart';

class UserRegisterEntity {

  final String? message;

  UserRegisterEntity({
    this.message
  });

  factory UserRegisterEntity.fromModel(UserRegisterModel model) => UserRegisterEntity(
    message: model.message,
  );
}