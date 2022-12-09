import 'package:flutter/material.dart';
import 'package:proyecto_consulta/estructurasDatos/estructuraHistorico/estructuraHistorico.dart';

class ProviderIngresar with ChangeNotifier {

  double _enStock = 0;


  double get enStock => _enStock;

  set actualizarStock(double nuevoStock) {
    _enStock = nuevoStock;
    notifyListeners();
  }

  List<EstructuraHistorico> historicoIngresar = [];


  List<EstructuraHistorico> get lista => historicoIngresar;

  set nuevoProducto(EstructuraHistorico nuevoProducto) {
    historicoIngresar.add(nuevoProducto) ;
    notifyListeners();
  }

}