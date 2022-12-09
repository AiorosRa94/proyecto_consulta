import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proyecto_consulta/APIs/UrlApis.dart';
import 'package:proyecto_consulta/estructurasDatos/ingresar/ingresarJSON.dart';

class ApiRecuento {
  Future<http.Response> recuentoStock(
      double stock, String varianteId, String nombreProducto, String token) {
    print(
        "BODY QUE SE ENVIA: ${jsonEncode(IngresarJson(stock: stock, variantId: varianteId, action: "setear", itemNamePrestado: nombreProducto).toJson()).toString()}");

    return http.post(Uri.parse(UrlApis.URL_API + 'index.php/changeStock'),
        body: jsonEncode(IngresarJson(
                    stock: stock,
                    variantId: varianteId,
                    action: "setear",
                    itemNamePrestado: nombreProducto)
                .toJson())
            .toString(),
        headers: {"Authorization": "Digest $token}"});
  }
}
