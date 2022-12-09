import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_consulta/recursos/responsivo/pantalla.dart';
import 'package:proyecto_consulta/widget/imagenes/imagenContenedor.dart';
import 'package:proyecto_consulta/widget/textos/textoAutoajustable.dart';

class CartaMenu extends StatelessWidget {

  final String urlImg, titulo;
  final String? subtitulo;
  final double? redondeo,elevacion;
  final double? anchoDisp,altoDisp, tamanoTextoTitulo, tamanoTextoSubtitulo, padding;
  final Color? colorCarta, colorTextoTitulo, colorTextoSubtitulo;
  
  const CartaMenu({required this.urlImg,required this.titulo,this.elevacion, this.redondeo, this.anchoDisp, this.altoDisp, this.colorCarta, this.colorTextoTitulo, this.colorTextoSubtitulo, this.subtitulo, this.tamanoTextoTitulo, this.tamanoTextoSubtitulo, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 10),
      child: Card(
          elevation: elevacion ?? 0,
          color: colorCarta ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(redondeo ?? 50),
          ),
          child: SizedBox(
            width: Pantalla(context).anchoDisp(anchoDisp ?? 7),
            height: Pantalla(context).altoDisp(altoDisp ?? 2),
            child: Center(
              child: Container(
                color: Colors.grey,
                width: Pantalla(context).anchoDisp(anchoDisp ?? 7),
                height: Pantalla(context).altoDisp(altoDisp ?? 2),
                child: Row(
                  children: [
                    ImagenContainer(imagen: urlImg,altoContainer: 1.5,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(titulo, style:GoogleFonts.rubik(fontSize: tamanoTextoTitulo ?? 0.1,color:colorTextoTitulo ?? Colors.black, fontWeight: FontWeight.bold,), textAlign: TextAlign.center),
                       ],
                    )
                  ],

                ),
              ),
            ),
          )
      ),
    );
  }
}
