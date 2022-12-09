import 'package:proyecto_consulta/recursos/responsivo/pantalla.dart';
import 'package:flutter/material.dart';

class TextoPlano extends StatelessWidget {
  final double? tamanoTexto;
  final String texto;
  final Color? colorTexto;
  final TextAlign? alineacionTexto;
  final FontWeight? pesoTexto;
  final double? paddingTexto;
  final double? altoContainer, anchoContainer;

  const TextoPlano({required this.texto,
    this.tamanoTexto, this.colorTexto,
    this.alineacionTexto, this.pesoTexto,
    this.paddingTexto, this.altoContainer,
    this.anchoContainer});

  @override
  Widget build(BuildContext context) {

    double tamano= tamanoTexto != null ? Pantalla(context).anchoDisp(tamanoTexto!) : Pantalla(context).anchoDisp(0.5);
    Color colorTxt = colorTexto ?? Colors.black;
    TextAlign alineacionTxt = alineacionTexto ?? TextAlign.center;
    FontWeight pesoTxt = pesoTexto ?? FontWeight.normal;
    double paddingTxt = paddingTexto ?? 10.0;

    return Padding(
      padding: EdgeInsets.all(paddingTxt),
      child: Text(texto, style: TextStyle(fontSize: tamano, color:colorTxt, fontWeight: pesoTxt,),maxLines: 2, textAlign: alineacionTxt,
      ),
    );
  }
}
