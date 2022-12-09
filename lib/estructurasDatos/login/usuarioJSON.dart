// To parse this JSON data, do
//
//     final usuarioJson = usuarioJsonFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UsuarioJson usuarioJsonFromJson(String str) => UsuarioJson.fromJson(json.decode(str));

String usuarioJsonToJson(UsuarioJson data) => json.encode(data.toJson());

class UsuarioJson {
  UsuarioJson({
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

  factory UsuarioJson.fromJson(Map<String, dynamic> json) => UsuarioJson(
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
