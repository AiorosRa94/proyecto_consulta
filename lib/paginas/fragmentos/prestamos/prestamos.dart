import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_consulta/APIs/clientes/ApiClientes.dart';
import 'package:proyecto_consulta/APIs/prestamos/apiPrestamos.dart';
import 'package:proyecto_consulta/APIs/productos/ApiProductos.dart';
import 'package:proyecto_consulta/estructurasDatos/estructuraHistorico/estructuraHistorico.dart';
import 'package:proyecto_consulta/providers/providerMenuDashboard/providerMenuDashboard.dart';
import 'package:proyecto_consulta/providers/providerPrestamo/providerPrestamo.dart';
import 'package:proyecto_consulta/providers/providerSqlite/providerCRUDCliente.dart';
import 'package:proyecto_consulta/providers/providerSqlite/providerCRUDProducto.dart';
import 'package:proyecto_consulta/providers/providerUsuario/providerUsuario.dart';
import 'package:proyecto_consulta/recursos/responsivo/pantalla.dart';
import 'package:proyecto_consulta/sqlite/modelos/cliente.dart';
import 'package:proyecto_consulta/sqlite/modelos/producto.dart';
import 'package:proyecto_consulta/widget/imagenes/imagenContenedor.dart';
import 'package:proyecto_consulta/widget/inputs/inputContainer.dart';
import 'package:proyecto_consulta/widget/inputs/inputSugerenciasCliente.dart';
import 'package:proyecto_consulta/widget/inputs/inputSugerenciasProducto.dart';
import 'package:proyecto_consulta/widget/textos/textoAutoajustable.dart';


class Prestamos extends StatelessWidget {
  const Prestamos({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {


    var providerPrestamo = Provider.of<ProviderPrestamo>(context);
    var providerSqliteProducto = Provider.of<ProviderCRUDProducto>(context);
    var providerSqliteCliente = Provider.of<ProviderCRUDCliente>(context);
    var providerMenuDashboard = Provider.of<ProviderMenuDashboard>(context);
    var providerUsuario = Provider.of<ProviderUsuario>(context);

    ApiPrestamos apiPrestamos = ApiPrestamos();

    TextEditingController controladorProducto = new TextEditingController();
    TextEditingController controladorEnStock = new TextEditingController();
    TextEditingController controladorCuantos = new TextEditingController();
    TextEditingController controladorQuien = new TextEditingController();



    return Column(
      children: [

        ImagenContainer(imagen: "assets/prestamos.png",altoContainer: 2),
        Padding(
          padding: EdgeInsets.only(top: Pantalla(context).altoDisp(0.5)),
          child: SizedBox (
            height: Pantalla(context).altoDisp(0.5) ,
            width: Pantalla(context).anchoDisp(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InputSugerenciasProducto(listaSug: providerSqliteProducto.listaSugerencias, controlador: controladorProducto,controladorStock: controladorEnStock,etiqueta: "Articulo o REF",anchoDisp: 3,altoDisp: 0.3,padding: 0, tamanoTexto: 0.2,),
                InputContainer(controlador: controladorEnStock,etiqueta: "En Stock",anchoDisp: 2.3,altoDisp: 0.3,padding: 0, tamanoTexto: 0.2,),
                InputContainer(controlador: controladorCuantos,etiqueta: "¿Cuantos?",anchoDisp: 2.3,altoDisp: 0.3,padding: 0, tamanoTexto: 0.2,),

              ],
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: Pantalla(context).altoDisp(0.5)),
          child: SizedBox (
            height: Pantalla(context).altoDisp(0.5) ,
            width: Pantalla(context).anchoDisp(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InputSugerenciasCliente(listaSug: providerSqliteCliente.listaSugerencias, controlador: controladorQuien,etiqueta: "¿Quien?",anchoDisp: 3,altoDisp: 0.3,padding: 0, tamanoTexto: 0.2,),
                Padding(
                  padding:  EdgeInsets.only(left: Pantalla(context).altoDisp(0.05), bottom: Pantalla(context).altoDisp(0.02)),
                  child: SizedBox(
                    height:Pantalla(context).altoDisp(0.3) ,
                    width: Pantalla(context).anchoDisp(2),
                    child: ElevatedButton(

                      onPressed: () async {
                        EasyLoading.show(status: 'Prestando...');
                        Producto prd = await  providerSqliteProducto.selectProducto(controladorProducto.text);
                        Cliente cli = await  providerSqliteCliente.selectCliente(controladorQuien.text);
                        
                        final respuesta = await apiPrestamos.prestar(cli.id, cli.proveedor, cli.agente, cli.nombre, cli.numeroTelefono, prd.nombre, prd.varianteId, double.parse(controladorCuantos.text), "prestar",providerUsuario.token);
                       
                        if(respuesta.statusCode == 200){
                          EasyLoading.dismiss();
                          providerPrestamo.nuevoPrestamo = EstructuraHistorico(producto: controladorProducto.text, cantidad: double.parse(controladorCuantos.text));
                          Provider.of<ApiProductos>(context,listen: false).getProductos(context,providerUsuario.token);
                          Provider.of<ApiClientes>(context,listen: false).getClientes(context,providerUsuario.token);
                        }
                        else {
                          EasyLoading.dismiss();
                          await FlutterPlatformAlert.showAlert(
                            windowTitle: '¡Oh no!',
                            text: 'Ocurrio un error al intentar prestar el producto',
                            alertStyle: AlertButtonStyle.ok,
                            iconStyle: IconStyle.information,
                          );                        }
                      },
                      child:  TextoAutoajustable(texto: "Prestar",colorTexto: Colors.white, tamanoTexto: 0.5,),
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: Pantalla(context).altoDisp(0.05), bottom: Pantalla(context).altoDisp(0.02)),
                  child: SizedBox(
                    height:Pantalla(context).altoDisp(0.3) ,
                    width: Pantalla(context).anchoDisp(2),
                    child: ElevatedButton(

                      onPressed: () async {
                        EasyLoading.show(status: 'Pidiendo...');

                        Producto prd = await  providerSqliteProducto.selectProducto(controladorProducto.text);
                        Cliente cli = await  providerSqliteCliente.selectCliente(controladorQuien.text);

                        final respuesta = await apiPrestamos.prestar(cli.id, cli.proveedor, cli.agente, cli.nombre, cli.numeroTelefono, prd.nombre, prd.varianteId, double.parse(controladorCuantos.text), "prestamo",providerUsuario.token);

                        if(respuesta.statusCode == 200){
                          EasyLoading.dismiss();

                          providerPrestamo.nuevoPrestamo = EstructuraHistorico(producto: controladorProducto.text, cantidad: double.parse(controladorCuantos.text));
                          Provider.of<ApiProductos>(context,listen: false).getProductos(context,providerUsuario.token);
                          Provider.of<ApiClientes>(context,listen: false).getClientes(context,providerUsuario.token);
                        }
                        else {
                          EasyLoading.dismiss();
                          await FlutterPlatformAlert.showAlert(
                            windowTitle: '¡Oh no!',
                            text: 'Ocurrio un error al intentar pedir el producto',
                            alertStyle: AlertButtonStyle.ok,
                            iconStyle: IconStyle.information,
                          );                        }                      },
                      child:  TextoAutoajustable(texto: "Prestamo",colorTexto: Colors.white),
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: Pantalla(context)
              .altoDisp(0.3)),
          child: SizedBox(
            height: Pantalla(context).altoDisp(0.6),
            width: Pantalla(context).anchoDisp(5),
            child: ElevatedButton(

              onPressed: () async {
                providerMenuDashboard.menu = 5;
              },
              child: TextoAutoajustable(texto: "Ver todos",
                colorTexto: Colors.white,
                tamanoTexto: 0.6,),
              style: ElevatedButton.styleFrom(
                elevation: 1,
                primary: Colors.purple.shade300,
                side: BorderSide(
                    width: 1.0, color: Colors.purple.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ),
        /*SizedBox(
          height: Pantalla(context).altoDisp(2) ,
          width: Pantalla(context).anchoDisp(7),
        )*/
      ],
    );
  }
}
