// To parse this JSON data, do
//
//     final prestarHistoricoJson = prestarHistoricoJsonFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PrestarHistoricoJson prestarHistoricoJsonFromJson(String str) => PrestarHistoricoJson.fromJson(json.decode(str));

String prestarHistoricoJsonToJson(PrestarHistoricoJson data) => json.encode(data.toJson());

class PrestarHistoricoJson {
  PrestarHistoricoJson({
    required this.variantId,
    required this.idPrestamo,
    required this.stock,
    required this.action,
  });

  String variantId;
  int idPrestamo;
  double stock;
  String action;

  factory PrestarHistoricoJson.fromJson(Map<String, dynamic> json) => PrestarHistoricoJson(
    variantId: json["variant_id"],
    idPrestamo: json["id_prestamo"],
    stock: json["stock"].toDouble(),
    action: json["action"],
  );

  Map<String, dynamic> toJson() => {
    "variant_id": variantId,
    "id_prestamo": idPrestamo,
    "stock": stock,
    "action": action,
  };
}
