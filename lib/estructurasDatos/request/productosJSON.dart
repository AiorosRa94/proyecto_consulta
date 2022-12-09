// To parse this JSON data, do
//
//     final productosJson = productosJsonFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductosJson productosJsonFromJson(String str) => ProductosJson.fromJson(json.decode(str));

String productosJsonToJson(ProductosJson data) => json.encode(data.toJson());

class ProductosJson {
  ProductosJson({
    required this.ok,
    required this.msg,
    required this.data,
    required this.info,
  });

  bool ok;
  String msg;
  List<Datum> data;
  Info info;

  factory ProductosJson.fromJson(Map<String, dynamic> json) => ProductosJson(
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
    required this.id,
    required this.itemName,
    required this.handel,
    required this.variantId,
    required this.inStock,
  });

  String id;
  String itemName;
  String handel;
  String variantId;
  double inStock;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    itemName: json["item_name"],
    handel: json["handel"],
    variantId: json["variant_id"],
    inStock: json["in_stock"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item_name": itemName,
    "handel": handel,
    "variant_id": variantId,
    "in_stock": inStock,
  };
}

class Info {
  Info({
    required this.countItem,
    required this.countResponse,
  });

  int countItem;
  int countResponse;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    countItem: json["count-item"],
    countResponse: json["count-response"],
  );

  Map<String, dynamic> toJson() => {
    "count-item": countItem,
    "count-response": countResponse,
  };
}
