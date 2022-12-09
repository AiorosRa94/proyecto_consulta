import 'package:flutter/material.dart';
import 'package:flutter_textfield_autocomplete/flutter_textfield_autocomplete.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_consulta/providers/providerSqlite/providerCRUDCliente.dart';
import 'package:proyecto_consulta/recursos/responsivo/pantalla.dart';
import 'package:proyecto_consulta/widget/textos/textoAutoajustable.dart';

class InputSugerenciasCliente extends StatelessWidget {
  final List<String> listaSug;
  final double? anchoDisp, altoDisp, padding, tamanoTexto;
  final TextEditingController controlador;
  final Color? colorInput;
  final String? etiqueta;
  const InputSugerenciasCliente({required this.listaSug, this.anchoDisp, this.altoDisp, this.padding, this.colorInput, this.etiqueta,required this.controlador, this.tamanoTexto});

  @override
  Widget build(BuildContext context) {
    GlobalKey<TextFieldAutoCompleteState<String>> _textFieldAutoCompleteKey =
    new GlobalKey();
    var providerSqlite = Provider.of<ProviderCRUDCliente>(context);


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextoAutoajustable(texto: etiqueta ?? "", colorTexto: Colors.blue.shade900,tamanoTexto: 0.3,),

        Container(
          height: Pantalla(context).altoDisp(altoDisp ?? 1) ,
          width: Pantalla(context).anchoDisp(anchoDisp ?? 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),

          ),
          child: TextFieldAutoComplete(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  filled: true,
                  fillColor: colorInput ?? Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  )
              ),

              clearOnSubmit: false,
              controller: controlador,
              itemSubmitted: (String item)  async {
                print('SELECCIONO $item');
                controlador.text = item;
              },
              key: _textFieldAutoCompleteKey,
              suggestions: listaSug,
              itemBuilder: (context, String item) {
                return Container(
                  padding: EdgeInsets.all(10),

                  child: SizedBox(
                    height: Pantalla(context).altoDisp(altoDisp ?? 1) ,
                    width: Pantalla(context).anchoDisp(anchoDisp ?? 1),
                    child: Row(
                      children: [
                        TextoAutoajustable(texto: item, colorTexto: Colors.black,tamanoTexto: 0.2,),
                      ],
                    ),
                  ),
                );
              },
              itemSorter: (String a, String b) {
                return a.compareTo(b);
              },
              itemFilter: (String item, query) {
                return item
                    .toLowerCase()
                    .startsWith(query.toLowerCase());
              }),
        ),
      ],
    );
  }
}
