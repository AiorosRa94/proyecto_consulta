import 'package:flutter/material.dart';
import 'package:proyecto_consulta/recursos/responsivo/pantalla.dart';

class ImagenBoton extends StatelessWidget {
  final double? anchoDisp, altoDisp, padding;
  final String urlImg;
  const ImagenBoton({this.anchoDisp, this.altoDisp, this.padding,required this.urlImg});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:EdgeInsets.only(top: Pantalla(context).altoDisp(padding ?? 0.2)),
      child: SizedBox(
          height: Pantalla(context).altoDisp(altoDisp ?? 1.5),
          width: Pantalla(context).anchoDisp(anchoDisp ?? 8),
          child: Image.asset(urlImg, fit: BoxFit.scaleDown,)
      ),
    );
  }
}
