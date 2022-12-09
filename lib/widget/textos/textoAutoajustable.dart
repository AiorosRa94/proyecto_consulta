import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_consulta/recursos/responsivo/pantalla.dart';
import 'package:flutter/material.dart';

class TextoAutoajustable extends StatelessWidget {
  final String texto;
  final double? tamanoTexto;
  final Color? colorTexto;
  final TextAlign? alineacionTexto;
  final FontWeight? pesoTexto;
  final double? paddingTexto;
  final double? altoContainer, anchoContainer;

  const TextoAutoajustable({required this.texto,
    this.tamanoTexto,
    this.alineacionTexto, this.pesoTexto,
    this.paddingTexto, this.altoContainer,
    this.anchoContainer, this.colorTexto});

  @override
  Widget build(BuildContext context) {

    Color colorTxt = colorTexto ?? Colors.black;
    double tamanoTxt = tamanoTexto != null ? Pantalla(context).anchoDisp(tamanoTexto!) : Pantalla(context).anchoDisp(0.5);
    TextAlign alineacionTxt = alineacionTexto ?? TextAlign.center;
    FontWeight pesoTxt = pesoTexto ?? FontWeight.normal;
    double paddingTxt = paddingTexto ?? 0;

    return Padding(
      padding: EdgeInsets.all(paddingTxt),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(texto, style:GoogleFonts.rubik(fontSize: tamanoTxt,color:colorTxt, fontWeight: pesoTxt,),maxLines: 2, textAlign: alineacionTxt,
        ),
      ),
    );
  }
}
