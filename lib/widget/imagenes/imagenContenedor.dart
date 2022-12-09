
import 'package:proyecto_consulta/recursos/responsivo/pantalla.dart';
import 'package:flutter/material.dart';

class ImagenContainer extends StatelessWidget {
  final String? imagen;
  final double? altoContainer;

  const ImagenContainer({this.imagen ,this.altoContainer});

  @override
  Widget build(BuildContext context) {

    double altoCont = altoContainer ?? 1;

    return SizedBox(
      height: Pantalla(context).altoDisp(altoCont) ,
      width: Pantalla(context).altoDisp(altoCont),
      child: Image.asset(imagen ?? "assets/logoMorado.png", fit: BoxFit.fitWidth,)
    );
  }
}
