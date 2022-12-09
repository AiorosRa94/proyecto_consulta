import 'package:flutter/material.dart';

class ProviderReporte extends ChangeNotifier{

  DateTime _fechaReporte = new DateTime(DateTime.now().year,DateTime.now().month - 1,DateTime.now().day);
  DateTime _fechaSeleccion = new DateTime(DateTime.now().year,DateTime.now().month - 1,DateTime.now().day);

  DateTime get fechaSeleccion => _fechaSeleccion;

  set fechaSeleccion(DateTime value) {
    _fechaSeleccion = value;
    notifyListeners();
  }

  DateTime get fechaReporte => _fechaReporte;

  set fechaReporte(DateTime value) {
    _fechaReporte = value;
    notifyListeners();
  }
}