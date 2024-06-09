class UserRegisterRequest {
  String? email;
  String? password;
  String? name;

  UserRegisterRequest({
    required this.email,
    required this.password,
    required this.name
  });

  factory UserRegisterRequest.fromJson(Map<String, dynamic> json) => UserRegisterRequest(
    email: json["Email"],
    password: json["Password"],
    name: json["name"]
  );

  Map<String, dynamic> toJson() => {
    "Email": email,
    "Password": password,
    "name": name
  };
}