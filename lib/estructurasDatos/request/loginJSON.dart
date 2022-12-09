import 'dart:convert';

LoginJson loginJsonFromJson(String str) => LoginJson.fromJson(json.decode(str));

String loginJsonToJson(LoginJson data) => json.encode(data.toJson());

class LoginJson {
  LoginJson({
    required this.usuario,
    required this.password,
  });

  String usuario;
  String password;

  factory LoginJson.fromJson(Map<String, dynamic> json) => LoginJson(
    usuario: json["usuario"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "usuario": usuario,
    "password": password,
  };
}
