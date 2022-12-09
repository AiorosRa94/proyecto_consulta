import 'package:flutter/material.dart';
import 'package:proyecto_consulta/estructurasDatos/estructuraHistorico/estructuraHistorico.dart';

class ProviderRecuento with ChangeNotifier {

  List<EstructuraHistorico> historicoRecuento = [];


  List<EstructuraHistorico> get lista => historicoRecuento;

  set nuevoProducto(EstructuraHistorico nuevoProducto) {
    historicoRecuento.add(nuevoProducto) ;
    notifyListeners();
  }

}