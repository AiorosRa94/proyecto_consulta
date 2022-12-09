
import 'package:flutter/material.dart';

class Pantalla {
  BuildContext context;
 late double _height;
 late double _width;


  Pantalla(this.context) {
    MediaQueryData _queryData = MediaQuery.of(context);
    _height = _queryData.size.height / 10 ;
    _width = _queryData.size.width / 10;
  }

  double altoDisp(double v) {
    return _height * v;
  }

  double anchoDisp(double v) {
    return _width * v;
  }


  bool esTablet() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 750 ? false : true;
  }

}