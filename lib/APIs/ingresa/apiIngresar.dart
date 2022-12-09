import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proyecto_consulta/APIs/UrlApis.dart';
import 'package:proyecto_consulta/estructurasDatos/ingresar/ingresarJSON.dart';

class ApiIngresar {
  Future<http.Response> ingresarStock(
      double stock, String varianteId, nombreItem, token) {
    print(
        "BODY QUE SE ENVIA: ${jsonEncode(IngresarJson(stock: stock, variantId: varianteId, action: "aumentar", itemNamePrestado: nombreItem).toJson()).toString()}");

    return http.post(
        Uri.parse(
            UrlApis.URL_API+'index.php/changeStock'),
        body: jsonEncode(IngresarJson(
                    stock: stock,
                    variantId: varianteId,
                    action: "aumentar",
                    itemNamePrestado: nombreItem)
                .toJson())
            .toString(),
    headers:  {
      "Authorization":"Digest $token}"
    });
  }
}
