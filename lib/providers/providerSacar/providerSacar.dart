import 'package:flutter/material.dart';
import 'package:proyecto_consulta/estructurasDatos/estructuraHistorico/estructuraHistorico.dart';

class ProviderSacar with ChangeNotifier {

  int enStock = 0;

  int get stock => enStock;


  set stock(int nuevoStock) {
    enStock -= nuevoStock;
    notifyListeners();
  }




  List<EstructuraHistorico> historicoSacar = [];


  List<EstructuraHistorico> get lista => historicoSacar;



  set nuevoProducto(EstructuraHistorico nuevoProducto) {
    historicoSacar.add(nuevoProducto) ;
    notifyListeners();
  }

}