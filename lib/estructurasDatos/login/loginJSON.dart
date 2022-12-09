// To parse this JSON data, do
//
//     final loginJson = loginJsonFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginJson loginJsonFromJson(String str) => LoginJson.fromJson(json.decode(str));

String loginJsonToJson(LoginJson data) => json.encode(data.toJson());

class LoginJson {
  LoginJson({
    required this.ok,
    required this.msg,
    required this.data,
    required this.info,
  });

  bool ok;
  String msg;
  List<dynamic> data;
  Info info;

  factory LoginJson.fromJson(Map<String, dynamic> json) => LoginJson(
    ok: json["ok"],
    msg: json["msg"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
    info: Info.fromJson(json["info"]),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x)),
    "info": info.toJson(),
  };
}

class Info {
  Info({
    required this.user,
    required this.token,
  });

  User user;
  String token;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "token": token,
  };
}

class User {
  User({
    required this.clienteId,
    required this.storeId,
    required this.nombreCliente,
    required this.nombreSucursal,
    required this.user,
  });

  String clienteId;
  String storeId;
  String nombreCliente;
  String nombreSucursal;
  String user;

  factory User.fromJson(Map<String, dynamic> json) => User(
    clienteId: json["cliente_id"],
    storeId: json["store_id"],
    nombreCliente: json["nombre_cliente"],
    nombreSucursal: json["nombre_sucursal"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "cliente_id": clienteId,
    "store_id": storeId,
    "nombre_cliente": nombreCliente,
    "nombre_sucursal": nombreSucursal,
    "user": user,
  };
}
