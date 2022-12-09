import 'dart:convert';

IngresarJson ingresarJsonFromJson(String str) => IngresarJson.fromJson(json.decode(str));

String ingresarJsonToJson(IngresarJson data) => json.encode(data.toJson());

class IngresarJson {

  IngresarJson({
    required this.stock,
    required this.variantId,
    required this.itemNamePrestado,
    required this.action,
  });

  double stock;
  String variantId;
  String action;
  String itemNamePrestado;

  factory IngresarJson.fromJson(Map<String, dynamic> json) => IngresarJson(
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
