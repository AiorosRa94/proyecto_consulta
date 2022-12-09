import 'dart:convert';

SacarJson sacarJsonFromJson(String str) => SacarJson.fromJson(json.decode(str));

String sacarJsonToJson(SacarJson data) => json.encode(data.toJson());

class SacarJson {

  SacarJson({
    required this.stock,
    required this.variantId,
    required this.itemNamePrestado,
    required this.action,
  });

  double stock;
  String variantId;
  String action;
  String itemNamePrestado;

  factory SacarJson.fromJson(Map<String, dynamic> json) => SacarJson(
    stock: json["stock"],
    variantId: json["variant_id"],
    itemNamePrestado: json["item_name_prestado"],
    action: json["action"],
  );

  Map<String, dynamic> toJson() => {
    "stock": stock,
    "variant_id": variantId,
    "item_name_prestado":itemNamePrestado,
    "action": action,
  };
}
