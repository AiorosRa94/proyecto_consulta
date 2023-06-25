import 'package:flutter/material.dart';
import 'package:proyecto_consulta/paginas/fragmentos/ingresar/ingresar.dart';
import 'package:proyecto_consulta/paginas/fragmentos/menu/menu.dart';
import 'package:proyecto_consulta/paginas/fragmentos/prestamos/prestamoQuienes.dart';
import 'package:proyecto_consulta/paginas/fragmentos/prestamos/prestamos.dart';
import 'package:proyecto_consulta/paginas/fragmentos/recuento/recuento.dart';
import 'package:proyecto_consulta/paginas/fragmentos/reporte/reporte.dart';
import 'package:proyecto_consulta/paginas/fragmentos/sacar/sacar.dart';

class ProviderMenuDashboard with ChangeNotifier {
  int _opcionSeleccionada = 0;

  List<Widget> opciones = [Menu(), Sacar(), Ingresar(), Recuento(), Prestamos(), PrestamosQuienes(), Reporte()];

  int get menu => _opcionSeleccionada;

  Widget get opcion => opciones[_opcionSeleccionada];

  set menu(int nuevaSeleccion) {
    _opcionSeleccionada = nuevaSeleccion;
    notifyListeners();
  }
}
