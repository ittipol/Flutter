class TokenVerifyModel {
  final String? message;

  TokenVerifyModel({
    this.message
  });

  factory TokenVerifyModel.fromJson(Map<String, dynamic> json) => TokenVerifyModel(
    message: json["message"]
  );

}