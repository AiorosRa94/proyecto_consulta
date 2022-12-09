
import 'package:proyecto_consulta/recursos/responsivo/pantalla.dart';
import 'package:flutter/material.dart';

class TextoContainer extends StatelessWidget {
  final double? tamanoTexto;
  final String texto;
  final Color? colorTexto;
  final TextAlign? alineacionTexto;
  final FontWeight? pesoTexto;
  final double? paddingTexto;
  final double? altoContainer, anchoContainer;

  const TextoContainer({required this.texto,
    this.tamanoTexto, this.colorTexto,
    this.alineacionTexto, this.pesoTexto,
    this.paddingTexto, this.altoContainer,
    this.anchoContainer});

  @override
  Widget build(BuildContext context) {

    double tamano= tamanoTexto != null ? Pantalla(context).altoDisp(tamanoTexto!) : Pantalla(context).altoDisp(0.5);
    Color colorTxt = colorTexto ?? Colors.black;
    TextAlign alineacionTxt = alineacionTexto ?? TextAlign.start;
    FontWeight pesoTxt = pesoTexto ?? FontWeight.normal;
    double paddingTxt = paddingTexto ?? 10.0;
    double altoCont = altoContainer ?? 1;
    double anchoCont = anchoContainer ?? 9;

    return Padding(
      padding: EdgeInsets.all(paddingTxt),
      child: Container(
        height: Pantalla(context).altoDisp(altoCont) ,
        width: Pantalla(context).anchoDisp(anchoCont),
        child: Text(texto, style: TextStyle(fontSize: tamano, color:colorTxt, fontWeight: pesoTxt,),maxLines: 2, textAlign: alineacionTxt,
        ),
      ),
    );
  }
}
