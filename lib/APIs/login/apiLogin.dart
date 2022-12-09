import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:proyecto_consulta/APIs/UrlApis.dart';
import 'package:proyecto_consulta/estructurasDatos/request/loginJSON.dart';
import 'package:proyecto_consulta/estructurasDatos/login/loginJSON.dart' as login;

class ApiLogin {
  Future<login.LoginJson?> loginRequest(String correo, String contrasena) async {
    print(
        "BODY QUE SE ENVIA: ${jsonEncode(LoginJson(usuario: correo, password: contrasena).toJson()).toString()}");

    var response = await http.post(
        Uri.parse(UrlApis.URL_API + 'index.php/login'),
        body: jsonEncode(
                LoginJson(usuario: correo, password: contrasena).toJson())
            .toString());

    if(response.statusCode == 200){
      login.LoginJson log = login.LoginJson.fromJson(jsonDecode(response.body));
      return log;
    }

    else{
      return null;
    }
  }
}
