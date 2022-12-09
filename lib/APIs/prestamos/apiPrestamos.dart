import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:proyecto_consulta/APIs/UrlApis.dart';
import 'package:proyecto_consulta/estructurasDatos/prestamo/prestamoJSON.dart';
import 'package:proyecto_consulta/estructurasDatos/prestamo/prestamosHistoricoJSON.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_consulta/estructurasDatos/request/prestarHistoricoJSON.dart';

class ApiPrestamos {
  String url = UrlApis.URL_API;

  Future<PrestamosHistoricoJson> getHistorico(
      BuildContext context, String token) async {
    print("ENTRO HISTORICO");

    final response = await http.get(Uri.parse(url + 'index.php/infoprestamos'),
        headers: {"Authorization": "Digest $token}"});

    if (response.statusCode == 200) {
      print("Devuelve ${response.body}");
      PrestamosHistoricoJson historico =
          PrestamosHistoricoJson.fromJson(jsonDecode(response.body));

      return historico;
    } else {
      print("Error al cargar los datos de prestamos ${response.statusCode}");

      PrestamosHistoricoJson historico =
          PrestamosHistoricoJson.fromJson(jsonDecode(response.body));
      return historico;
    }
  }

  Future<http.Response> prestar(
      String clienteId,
      String proveedor,
      String agente,
      String clienteName,
      String contactoCliente,
      String itemNamePrestado,
      String variantId,
      double cuantos,
      String accion,
      String token) {
    print(
        "BODY QUE SE ENVIA: ${jsonEncode(PrestamosJson(proveedor: proveedor, clienteName: clienteName, clienteId: clienteId, contactoCliente: contactoCliente, itemNamePrestado: itemNamePrestado, variantId: variantId, stock: cuantos, action: accion).toJson()).toString()}");

    return http.post(Uri.parse(url + 'index.php/prestamos'),
        body: jsonEncode(PrestamosJson(
                    proveedor: proveedor,
                    clienteName: clienteName,
                    clienteId: clienteId,
                    contactoCliente: contactoCliente,
                    itemNamePrestado: itemNamePrestado,
                    variantId: variantId,
                    stock: cuantos,
                    action: accion)
                .toJson())
            .toString(),
        headers: {"Authorization": "Digest $token}"});
  }

  Future<http.Response> pagos(int idPrestamo, String variantId, double cuantos,
      String accion, String token) {
    print(
        "BODY QUE SE ENVIA: ${jsonEncode(PrestarHistoricoJson(variantId: variantId, idPrestamo: idPrestamo, stock: cuantos, action: accion).toJson()).toString()}");

    return http.post(Uri.parse(url + 'index.php/pago'),
        body: jsonEncode(PrestarHistoricoJson(
                    variantId: variantId,
                    idPrestamo: idPrestamo,
                    stock: cuantos,
                    action: accion)
                .toJson())
            .toString(),
        headers: {"Authorization": "Digest $token}"});
  }
}
