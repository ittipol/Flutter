import 'package:flutter_demo/data/models/profile/user_profile_model.dart';

class UserProfileEntity {

  final String? name;

  UserProfileEntity({
    this.name
  });

  factory UserProfileEntity.fromModel(UserProfileModel model) => UserProfileEntity(
    name: model.name,
  );
}