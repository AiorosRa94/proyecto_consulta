import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_consulta/APIs/UrlApis.dart';
import 'package:proyecto_consulta/estructurasDatos/request/productosJSON.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_consulta/providers/providerSqlite/providerCRUDProducto.dart';
import 'package:proyecto_consulta/sqlite/modelos/producto.dart';


class ApiProductos with ChangeNotifier{

  bool _cargoProd = false;

  bool get cargoProd => _cargoProd;

  Future<void> getProductos(BuildContext context, String token) async {
    var providerSQliteProducto = Provider.of<ProviderCRUDProducto>(context,listen: false);

    final response = await http
        .get(Uri.parse(UrlApis.URL_API+'index.php/stock'),
        headers: {
          "Authorization":"Digest $token}"
        });
    if (response.statusCode == 200) {
     ProductosJson prd =  ProductosJson.fromJson(jsonDecode(response.body));

     for(int i = 0; i < prd.data.length; i++){
       print("Se agregara: ${prd.data[i].itemName}");
       providerSQliteProducto.nuevoProducto(Producto(
           nombre: Utf8Decoder().convert(prd.data[i].itemName.codeUnits),
           varianteId: prd.data[i]
               .variantId,
           enStock: prd.data[i].inStock.toString()));
     }

     _cargoProd = true;

    } else {
      print("Error al cargar los datos de Producto ${response.statusCode}");
      _cargoProd = false;
    }
    notifyListeners();

  }

}






