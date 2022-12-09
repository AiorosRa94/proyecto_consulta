import 'package:flutter/material.dart';
import 'package:proyecto_consulta/recursos/responsivo/pantalla.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_consulta/widget/textos/textoAutoajustable.dart';
class InputContainer extends StatelessWidget {
  final double? anchoDisp, altoDisp, padding, tamanoTexto;
  final TextEditingController controlador;
  final Color? colorInput;
  final String? etiqueta;

  const InputContainer({this.anchoDisp, this.altoDisp, this.padding, this.colorInput, this.etiqueta,required this.controlador, this.tamanoTexto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(Pantalla(context).altoDisp(padding ?? 0.1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextoAutoajustable(texto: etiqueta ?? "", colorTexto: Colors.blue.shade900,tamanoTexto: 0.3,),
          SizedBox(
            height: Pantalla(context).altoDisp(altoDisp ?? 1) ,
            width: Pantalla(context).anchoDisp(anchoDisp ?? 1),
            child: TextFormField(
              controller: controlador,
              style: GoogleFonts.rubik(color: Colors.black, fontSize: Pantalla(context).altoDisp(tamanoTexto ?? 0.1)),
              textAlign: TextAlign.start,

              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  filled: true,
                  fillColor: colorInput ?? Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
