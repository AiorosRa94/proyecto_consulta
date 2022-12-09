import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proyecto_consulta/APIs/UrlApis.dart';
import 'package:proyecto_consulta/estructurasDatos/sacar/sacarJSON.dart';

class ApiSacar {
  Future<http.Response> sacarDeStock(
      double stock, String varianteId, String nombreProducto, String token) {
    print(
        "BODY QUE SE ENVIA: ${jsonEncode(SacarJson(stock: stock, variantId: varianteId, action: "decrementar", itemNamePrestado: nombreProducto).toJson()).toString()}");

    return http.post(Uri.parse(UrlApis.URL_API + 'index.php/changeStock'),
        body: jsonEncode(SacarJson(
                    stock: stock,
                    variantId: varianteId,
                    action: "decrementar",
                    itemNamePrestado: nombreProducto)
                .toJson())
            .toString(),
        headers: {"Authorization": "Digest $token}"});
  }
}
