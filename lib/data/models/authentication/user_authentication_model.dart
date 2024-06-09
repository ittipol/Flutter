class UserAuthenticationModel {
  final String? accessToken;
  final String? refreshToken;

  UserAuthenticationModel({
    this.accessToken,
    this.refreshToken,
  });

  factory UserAuthenticationModel.fromJson(Map<String, dynamic> json) => UserAuthenticationModel(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"]
  );

}