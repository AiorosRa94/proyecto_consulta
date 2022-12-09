import 'package:flutter/material.dart';

class ProviderStorage with ChangeNotifier {

  bool _permisoStorage = false;


  bool get permisoStorage => _permisoStorage;

  set permisoStorage(bool nuevoValor) {
    _permisoStorage = nuevoValor;
    notifyListeners();
  }


}