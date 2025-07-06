class UserProfileModel {
  final String? name;

  UserProfileModel({
    this.name
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    name: json["name"]
  );

}