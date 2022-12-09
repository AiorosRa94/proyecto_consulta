import 'package:flutter/material.dart';
import 'package:proyecto_consulta/paginasTablet/fragmentos/mainFragmentTablet/mainFragmentTablet.dart';
import 'package:proyecto_consulta/paginasTablet/fragmentos/menuTablet/menuTablet.dart';
import 'package:proyecto_consulta/paginasTablet/fragmentos/sacarTablet/sacarTablet.dart';

class ProviderNavBarTablet with ChangeNotifier {

  int _menuSeleccionado = 0;

  List<Widget> pantallas = [MainFragmentTablet(),MenuTablet(),MenuTablet(),MenuTablet(),SacarTablet()];


  int get menu => _menuSeleccionado;

  Widget get pantalla => pantallas[_menuSeleccionado];

  set menu(int nuevaSeleccion) {
    _menuSeleccionado = nuevaSeleccion;
    notifyListeners();
  }

}