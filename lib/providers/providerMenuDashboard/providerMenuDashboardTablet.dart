import 'package:flutter/material.dart';
import 'package:proyecto_consulta/paginasTablet/fragmentos/ingresarTablet/ingresarTablet.dart';
import 'package:proyecto_consulta/paginasTablet/fragmentos/menuTablet/menuTablet.dart';
import 'package:proyecto_consulta/paginasTablet/fragmentos/prestamosTablet/prestamoQuienesTablet.dart';
import 'package:proyecto_consulta/paginasTablet/fragmentos/prestamosTablet/prestamosTablet.dart';
import 'package:proyecto_consulta/paginasTablet/fragmentos/recuentoTablet/recuentoTablet.dart';
import 'package:proyecto_consulta/paginasTablet/fragmentos/sacarTablet/sacarTablet.dart';
class ProviderMenuDashboardTablet with ChangeNotifier {

  int _opcionSeleccionada = 0;


  List<Widget> opciones = [MenuTablet(),SacarTablet(),IngresarTablet(),RecuentoTablet(), PrestamosTablet(),PrestamosQuienesTablet()];


  int get menu => _opcionSeleccionada;

  Widget get opcion => opciones[_opcionSeleccionada];

  set menu(int nuevaSeleccion) {
    _opcionSeleccionada = nuevaSeleccion;
    notifyListeners();
  }

}