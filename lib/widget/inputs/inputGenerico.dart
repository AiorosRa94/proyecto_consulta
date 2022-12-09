import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_consulta/recursos/responsivo/pantalla.dart';

class InputGenerico extends StatelessWidget {
  final String? hint;
  final TextEditingController controlador;
  final double? tamanoTexto;
  final Color? colorTexto,colorHint, colorCursor, colorLinea;
  final TextAlign? alineacionTexto;
  final FontWeight? pesoTexto;
  final double? altoContainer, anchoContainer;
  final bool? esContrasena, autocorrector;
  final TextInputType? tipoTeclado;

  const InputGenerico({required this.controlador,
    this.hint, this.tamanoTexto, this.colorTexto,
    this.alineacionTexto, this.pesoTexto, this.altoContainer,
    this.anchoContainer, this.colorHint, this.esContrasena,
    this.tipoTeclado, this.autocorrector, this.colorCursor,
    this.colorLinea});

  @override
  Widget build(BuildContext context) {

    double txtTamano = Pantalla(context).altoDisp(tamanoTexto ?? 0.2);

    return  Container(
      height: Pantalla(context).altoDisp(altoContainer ?? 1),
      width: Pantalla(context).anchoDisp(anchoContainer ?? 1),
      child: TextFormField(
        controller: controlador,
        textAlign: TextAlign.left,
        obscureText: esContrasena ?? false,
        keyboardType: tipoTeclado ?? TextInputType.text,
        autocorrect: autocorrector ?? false,
        cursorColor: Colors.white,
        style: GoogleFonts.rubik(color: colorTexto, fontSize: txtTamano),
        decoration: InputDecoration(

            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorLinea ?? Colors.black),
            ),

          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colorCursor ?? Colors.black),
          ),
          labelStyle: GoogleFonts.rubik(color: Colors.redAccent, fontSize: txtTamano, fontWeight: pesoTexto ?? FontWeight.normal),
          hintText: hint,
          alignLabelWithHint: true,
          hoverColor: colorCursor,
          hintStyle:  GoogleFonts.rubik(color: colorHint ?? Colors.grey , fontSize: txtTamano , fontWeight: pesoTexto ?? FontWeight.normal),
        ),
      ),
    );
  }
}
