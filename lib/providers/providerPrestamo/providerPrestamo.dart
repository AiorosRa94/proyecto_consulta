import 'package:flutter/material.dart';
import 'package:proyecto_consulta/estructurasDatos/estructuraHistorico/estructuraHistorico.dart';

class ProviderPrestamo with ChangeNotifier {

  int enStock = 0;

  int get stock => enStock;


  set stock(int nuevoStock) {
    enStock -= nuevoStock;
    notifyListeners();
  }


  List<EstructuraHistorico> historicoPrestamo = [];


  List<EstructuraHistorico> get lista => historicoPrestamo;


  set nuevoPrestamo(EstructuraHistorico nuevoPrestamo) {
    historicoPrestamo.add(nuevoPrestamo) ;
    notifyListeners();
  }

}