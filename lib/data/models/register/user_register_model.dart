class UserRegisterModel {
  final String? message;

  UserRegisterModel({
    this.message
  });

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) => UserRegisterModel(
    message: json["message"]
  );

}