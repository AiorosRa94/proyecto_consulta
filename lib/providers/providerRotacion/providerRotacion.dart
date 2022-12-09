import 'package:flutter/material.dart';

class ProviderRotacion with ChangeNotifier {
  bool _esPortrait = true;

  bool get esPortrait => _esPortrait;

  set esPortrait(bool nuevoValor){
    _esPortrait = nuevoValor;
    notifyListeners();
  }



}