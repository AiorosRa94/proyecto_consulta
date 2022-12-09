// To parse this JSON data, do
//
//     final prestamosHistoricoJson = prestamosHistoricoJsonFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PrestamosHistoricoJson prestamosHistoricoJsonFromJson(String str) => PrestamosHistoricoJson.fromJson(json.decode(str));

String prestamosHistoricoJsonToJson(PrestamosHistoricoJson data) => json.encode(data.toJson());

class PrestamosHistoricoJson {
  PrestamosHistoricoJson({
    required this.ok,
    required this.msg,
    required this.data,
    required this.info,
  });

  bool ok;
  String msg;
  List<Datum> data;
  Info info;

  factory PrestamosHistoricoJson.fromJson(Map<String, dynamic> json) => PrestamosHistoricoJson(
    ok: json["ok"],
    msg: json["msg"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    info: Info.fromJson(json["info"]),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "info": info.toJson(),
  };
}

class Datum {
  Datum({
    required this.storeIdCliente,
    required this.cliente,
    required this.contactoCliente,
    required this.debe,
    required this.debo,
  });

  String storeIdCliente;
  String cliente;
  String contactoCliente;
  List<Deb> debe;
  List<Deb> debo;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    storeIdCliente: json["store_id_cliente"],
    cliente: json["cliente"],
    contactoCliente: json["contactoCliente"],
    debe: List<Deb>.from(json["debe"].map((x) => Deb.fromJson(x))),
    debo: List<Deb>.from(json["debo"].map((x) => Deb.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "store_id_cliente": storeIdCliente,
    "cliente": cliente,
    "contactoCliente": contactoCliente,
    "debe": List<dynamic>.from(debe.map((x) => x.toJson())),
    "debo": List<dynamic>.from(debo.map((x) => x.toJson())),
  };
}

class Deb {
  Deb({
    required this.idPrestamo,
    required this.item,
    required this.cantidad,
    required this.variantId,
  });

  int idPrestamo;
  String item;
  String cantidad;
  String variantId;

  factory Deb.fromJson(Map<String, dynamic> json) => Deb(
    idPrestamo: json["id_prestamo"],
    item: json["item"],
    cantidad: json["cantidad"],
    variantId: json["variant_id"],
  );

  Map<String, dynamic> toJson() => {
    "id_prestamo": idPrestamo,
    "item": item,
    "cantidad": cantidad,
    "variant_id": variantId,
  };
}

class Info {
  Info();

  factory Info.fromJson(Map<String, dynamic> json) => Info(
  );

  Map<String, dynamic> toJson() => {
  };
}
