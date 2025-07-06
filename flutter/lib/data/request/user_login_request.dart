class UserLoginRequest {
  String? email;
  String? password;

  UserLoginRequest({
    required this.email,
    required this.password
  });

  factory UserLoginRequest.fromJson(Map<String, dynamic> json) => UserLoginRequest(
    email: json["Email"],
    password: json["Password"]
  );

  Map<String, dynamic> toJson() => {
    "Email": email,
    "Password": password
  };
}