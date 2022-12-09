import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_consulta/APIs/UrlApis.dart';
import 'package:proyecto_consulta/estructurasDatos/request/clientesJSON.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_consulta/providers/providerSqlite/providerCRUDCliente.dart';
import 'package:proyecto_consulta/sqlite/modelos/cliente.dart';

class ApiClientes with ChangeNotifier{
  bool _cargoCli = false;

  bool get cargoCli => _cargoCli;

  Future<void> getClientes(BuildContext context, String token) async {

    var providerSQliteClientes = Provider.of<ProviderCRUDCliente>(context, listen: false);

    final response = await http
        .get(Uri.parse(UrlApis.URL_API+'index.php/customers'),
    headers: {
          "Authorization":"Digest $token}"
    });

    if (response.statusCode == 200) {
      ClientesJson cli =  ClientesJson.fromJson(jsonDecode(response.body));

      for(int i = 0; i < cli.data.length; i++){
        print("Se agregara: ${cli.data[i].name}");
        providerSQliteClientes.nuevoCliente(Cliente(
            id: cli.data[i].id,
            agente: Utf8Decoder().convert(cli.data[i].note.codeUnits),
            nombre: Utf8Decoder().convert(cli.data[i].name.codeUnits),
            proveedor: Utf8Decoder().convert(cli.data[i].note.codeUnits),
            numeroTelefono: cli.data[i].phoneNumber
        )
        );

        _cargoCli = true;

      }

    } else {
      _cargoCli = false;
      print(response.body);
      throw Exception('Error al cargar los datos de Cliente ${response.statusCode}');
    }
    notifyListeners();

  }

}










