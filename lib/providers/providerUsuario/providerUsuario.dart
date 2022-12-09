import 'package:flutter/material.dart';
import 'package:proyecto_consulta/estructurasDatos/login/usuarioJSON.dart';

class ProviderUsuario with ChangeNotifier {

  late UsuarioJson _usuario;
  String _token = "";


  UsuarioJson get usuario => _usuario;

  set usuario(UsuarioJson usr) {
    _usuario = usr;
    notifyListeners();
  }

  String get token => _token;

  set token(String nuevoToken) {
    _token = nuevoToken;
    notifyListeners();
  }

}