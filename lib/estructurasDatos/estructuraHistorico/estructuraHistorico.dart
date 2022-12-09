import 'dart:convert';

EstructuraHistorico estructuraHistoricoFromJson(String str) => EstructuraHistorico.fromJson(json.decode(str));

String estructuraHistoricoToJson(EstructuraHistorico data) => json.encode(data.toJson());

class EstructuraHistorico {
  EstructuraHistorico({
    required this.producto,
    required this.cantidad,
  });

  String producto;
  double cantidad;

  factory EstructuraHistorico.fromJson(Map<String, dynamic> json) => EstructuraHistorico(
    producto: json["producto"],
    cantidad: json["cantidad"],
  );

  Map<String, dynamic> toJson() => {
    "producto": producto,
    "cantidad": cantidad,
  };
}
