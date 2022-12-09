import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_consulta/APIs/clientes/ApiClientes.dart';
import 'package:proyecto_consulta/APIs/productos/ApiProductos.dart';
import 'package:proyecto_consulta/APIs/recuento/apiRecuento.dart';
import 'package:proyecto_consulta/estructurasDatos/estructuraHistorico/estructuraHistorico.dart';
import 'package:proyecto_consulta/providers/providerRecuento/providerRecuento.dart';
import 'package:proyecto_consulta/providers/providerSqlite/providerCRUDProducto.dart';
import 'package:proyecto_consulta/providers/providerUsuario/providerUsuario.dart';
import 'package:proyecto_consulta/recursos/responsivo/pantalla.dart';
import 'package:proyecto_consulta/sqlite/modelos/producto.dart';
import 'package:proyecto_consulta/widget/imagenes/imagenContenedor.dart';
import 'package:proyecto_consulta/widget/inputs/inputContainer.dart';
import 'package:proyecto_consulta/widget/inputs/inputSugerenciasProducto.dart';
import 'package:proyecto_consulta/widget/textos/textoAutoajustable.dart';
import 'package:proyecto_consulta/widget/textos/textoContainer.dart';


class Recuento extends StatelessWidget {
  const Recuento({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    var providerRecuento = Provider.of<ProviderRecuento>(context);
    var providerSqlite = Provider.of<ProviderCRUDProducto>(context);
    var providerUsuario = Provider.of<ProviderUsuario>(context);

    ApiRecuento apiRecuento = ApiRecuento();

    TextEditingController controladorProducto = new TextEditingController();
    TextEditingController controladorEnStock = new TextEditingController();
    TextEditingController controladorAjustar = new TextEditingController();


    return Column(
      children: [

        ImagenContainer(imagen: "assets/recuento.png",altoContainer: 2),
        Padding(
          padding: EdgeInsets.only(top: Pantalla(context).altoDisp(0.5)),
          child: SizedBox (
            height: Pantalla(context).altoDisp(1) ,
            width: Pantalla(context).anchoDisp(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InputSugerenciasProducto(listaSug: providerSqlite.listaSugerencias, controlador: controladorProducto,controladorStock: controladorEnStock,etiqueta: "Articulo o REF",anchoDisp: 3,altoDisp: 0.3,padding: 0, tamanoTexto: 0.2,),
                InputContainer(controlador: controladorEnStock,etiqueta: "En Stock",anchoDisp: 2.3,altoDisp: 0.3,padding: 0, tamanoTexto: 0.2,),
                InputContainer(controlador: controladorAjustar,etiqueta: "Ajustar",anchoDisp: 2.3,altoDisp: 0.3,padding: 0, tamanoTexto: 0.2,),

              ],
            ),
          ),
        ),

        SizedBox(
          height: Pantalla(context).altoDisp(0.5) ,
          width: Pantalla(context).anchoDisp(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom:Pantalla(context).altoDisp(0.15)),
                child: SizedBox(
                  height:Pantalla(context).altoDisp(0.3) ,
                  width: Pantalla(context).anchoDisp(2),
                  child: ElevatedButton(

                    onPressed: () async {
                      EasyLoading.show(status: 'Actualizando...');

                      Producto prd = await  providerSqlite.selectProducto(controladorProducto.text);
                      final respuesta = await apiRecuento.recuentoStock(double.parse(controladorAjustar.text), prd.varianteId,prd.nombre,providerUsuario.token);
                      if(respuesta.statusCode == 200){
                        EasyLoading.dismiss();
                        providerRecuento.nuevoProducto = EstructuraHistorico(producto: controladorProducto.text, cantidad: double.parse(controladorAjustar.text));
                        Provider.of<ApiProductos>(context,listen: false).getProductos(context,providerUsuario.token);
                        Provider.of<ApiClientes>(context,listen: false).getClientes(context,providerUsuario.token);
                      }
                      else {
                        EasyLoading.dismiss();
                        await FlutterPlatformAlert.showAlert(
                          windowTitle: '¡Oh no!',
                          text: 'Ocurrio un error al intentar actualizar el producto',
                          alertStyle: AlertButtonStyle.ok,
                          iconStyle: IconStyle.information,
                        );                      }

                    },
                    child:  TextoAutoajustable(texto: "Actualizar",colorTexto: Colors.white,),
                    style: ElevatedButton.styleFrom(
                      elevation: 1,
                      primary: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: Pantalla(context).altoDisp(0)),
          child: Container (
              color: Colors.white,
              height: Pantalla(context).altoDisp(3) ,
              width: Pantalla(context).anchoDisp(8),
              child: ListView.builder(
                  itemCount: providerRecuento.historicoRecuento.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextoContainer(texto: "${providerRecuento.historicoRecuento[index].producto}", colorTexto: Colors.grey.shade500, alineacionTexto: TextAlign.start, tamanoTexto: 0.25, altoContainer: 0.5,anchoContainer: 3, paddingTexto: 0),
                        TextoContainer(texto: "${providerRecuento.historicoRecuento[index].cantidad}", colorTexto: Colors.blue, alineacionTexto: TextAlign.center, tamanoTexto: 0.25, altoContainer: 0.5,anchoContainer: 2, paddingTexto: 0)
                      ],
                    );
                  }
              )
          ),
        ),

      ],
    );
  }
}
