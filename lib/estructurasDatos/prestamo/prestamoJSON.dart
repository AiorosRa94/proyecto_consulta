
import 'dart:convert';

PrestamosJson prestamosJsonFromJson(String str) => PrestamosJson.fromJson(json.decode(str));

String prestamosJsonToJson(PrestamosJson data) => json.encode(data.toJson());

class PrestamosJson {
  PrestamosJson({
    required this.proveedor,
    required this.clienteName,
    required this.clienteId,
    required this.contactoCliente,
    required this.itemNamePrestado,
    required this.variantId,
    required this.stock,
    required this.action,
  });

  String proveedor;
  String clienteName;
  String clienteId;
  String contactoCliente;
  String itemNamePrestado;
  String variantId;
  double stock;
  String action;

  factory PrestamosJson.fromJson(Map<String, dynamic> json) => PrestamosJson(
    proveedor: json["proveedor"],
    clienteName: json["cliente_name"],
    clienteId: json["cliente_id"],
    contactoCliente: json["contacto_cliente"],
    itemNamePrestado: json["item_name_prestado"],
    variantId: json["variant_id"],
    stock: json["stock"].toDouble(),
    action: json["action"],
  );

  Map<String, dynamic> toJson() => {
    "proveedor": proveedor,
    "cliente_name": clienteName,
    "cliente_id": clienteId,
    "contacto_cliente": contactoCliente,
    "item_name_prestado": itemNamePrestado,
    "variant_id": variantId,
    "stock": stock,
    "action": action,
  };
}
