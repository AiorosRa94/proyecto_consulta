import 'package:flutter/material.dart';
import 'package:proyecto_consulta/paginas/fragmentos/mainFragment/mainFragment.dart';
import 'package:proyecto_consulta/paginas/fragmentos/menu/menu.dart';
import 'package:proyecto_consulta/paginas/fragmentos/sacar/sacar.dart';

class ProviderNavBar with ChangeNotifier {

int _menuSeleccionado = 0;

List<Widget> pantallas = [MainFragment(),Menu(),Menu(),Menu(),Sacar()];


int get menu => _menuSeleccionado;

Widget get pantalla => pantallas[_menuSeleccionado];

set menu(int nuevaSeleccion) {
  _menuSeleccionado = nuevaSeleccion;
  notifyListeners();
}

}