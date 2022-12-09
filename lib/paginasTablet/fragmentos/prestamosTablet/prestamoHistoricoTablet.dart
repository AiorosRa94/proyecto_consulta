import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_consulta/APIs/prestamos/apiPrestamos.dart';
import 'package:proyecto_consulta/estructurasDatos/prestamo/prestamosHistoricoJSON.dart';
import 'package:proyecto_consulta/providers/providerMenuDashboard/providerMenuDashboardTablet.dart';
import 'package:proyecto_consulta/providers/providerUsuario/providerUsuario.dart';
import 'package:proyecto_consulta/recursos/responsivo/pantalla.dart';
import 'package:proyecto_consulta/widget/imagenes/imagenContenedor.dart';
import 'package:proyecto_consulta/widget/inputs/inputGenerico.dart';
import 'package:proyecto_consulta/widget/textos/textoAutoajustable.dart';
import 'package:proyecto_consulta/widget/textos/textoContainer.dart';

class PrestamoHistoricoTablet extends StatefulWidget {

  final PrestamosHistoricoJson datos;
  final int indexCliente;

  PrestamoHistoricoTablet({required  this.datos, required  this.indexCliente});

  @override
  State<PrestamoHistoricoTablet> createState() => _PrestamoHistoricoTabletState();
}

class _PrestamoHistoricoTabletState extends State<PrestamoHistoricoTablet> {


  List<TextEditingController> _controladorCobrar = [];

  List<TextEditingController> _controladorPagar = [];

  ApiPrestamos apiPrestamos = ApiPrestamos();


  @override
  Widget build(BuildContext context) {
    var providerMenuDashboardTablet = Provider.of<ProviderMenuDashboardTablet>(context);
    var providerUsuario = Provider.of<ProviderUsuario>(context);


    for (int i = 0; i < widget.datos.data[widget.indexCliente].debe.length; i++) {
      _controladorCobrar.add(TextEditingController());
    }

    for (int i = 0; i < widget.datos.data[widget.indexCliente].debo.length; i++) {
      _controladorPagar.add(TextEditingController());
    }

    return WillPopScope(
      onWillPop: () {

        Navigator.pop(context);
        //we need to return a future
        return Future.value(false);
      },
      child:   Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background_dashboard.png"),
                fit: BoxFit.fill),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 30, right: 30, bottom: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: () {
                          Navigator.pop(context);
                        },
                          icon: Icon(FontAwesomeIcons.arrowLeft,
                              color: Colors.white,
                              size: Pantalla(context).altoDisp(0.3)),)

                      ],
                    ),
                  ),

                  ImagenContainer(imagen: "assets/prestamos.png",altoContainer: 3),
                  TextoContainer(texto: widget.datos.data[widget.indexCliente].cliente, colorTexto: Colors.deepPurple, anchoContainer: 8, altoContainer: 0.5, tamanoTexto: 0.5,),
                  SizedBox(
                    height: Pantalla(context).altoDisp(7),
                    width: Pantalla(context).anchoDisp(8),
                    child: Card(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: SizedBox(
                                height: Pantalla(context).altoDisp(0.5),
                                width: Pantalla(context).anchoDisp(7),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    TextoAutoajustable(texto: "Me debe", colorTexto: Colors.green, tamanoTexto: 1,),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height:Pantalla(context).altoDisp(2) ,
                              width: Pantalla(context).anchoDisp(7),
                              child: ListView.separated(
                                itemCount: widget.datos.data[widget.indexCliente].debe.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context,int index){
                                  return
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0),
                                          child: TextoAutoajustable(texto: widget.datos.data[widget.indexCliente].debe[index].item, tamanoTexto: widget.datos.data[widget.indexCliente].debe[index].item.length > 12 ? 0.1 : 0.2,colorTexto: Colors.grey,altoContainer: 0.05,),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(right: 10.0),
                                          child: Row(
                                            children: [
                                              TextoAutoajustable(texto: double.parse(widget.datos.data[widget.indexCliente].debe[index].cantidad).toStringAsFixed(2), tamanoTexto: 0.2,colorTexto: Colors.green,altoContainer: 0.1,),
                                              SizedBox(width: Pantalla(context).anchoDisp(0.2),),
                                              InputGenerico(controlador: _controladorCobrar[index], colorLinea: Colors.green,tamanoTexto: 0.3,altoContainer: 0.1,)
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: Pantalla(context).altoDisp(0.4),
                                          width: Pantalla(context).anchoDisp(2),
                                          child: ElevatedButton(

                                            onPressed: () async {
                                              EasyLoading.show(status: 'Cobrando...');


                                              if(double.parse(widget.datos.data[widget.indexCliente].debe[index].cantidad) >= double.parse(_controladorCobrar[index].text)){
                                                //Cliente cli = await  providerSqliteCliente.selectCliente(widget.datos.data[widget.indexCliente].cliente);


                                                if(double.parse(widget.datos.data[widget.indexCliente].debe[index].cantidad) - double.parse(_controladorCobrar[index].text) == 0 && (widget.datos.data[widget.indexCliente].debe.length == 1 && widget.datos.data[widget.indexCliente].debo.length == 0)){
                                                  final respuesta = await apiPrestamos.pagos(widget.datos.data[widget.indexCliente].debe[index].idPrestamo, widget.datos.data[widget.indexCliente].debe[index].variantId, double.parse(_controladorCobrar[index].text),  "cobro",providerUsuario.token);

                                                  if(respuesta.statusCode == 200){
                                                    EasyLoading.dismiss();
                                                    providerMenuDashboardTablet.menu = 4;
                                                    Navigator.pop(context);
                                                  }
                                                  else {
                                                    EasyLoading.dismiss();

                                                    await FlutterPlatformAlert.showAlert(
                                                      windowTitle: '¡Oh no!',
                                                      text: 'Ocurrio un error al cobrar el producto',
                                                      alertStyle: AlertButtonStyle.ok,
                                                      iconStyle: IconStyle.information,
                                                    );                                            }
                                                }
                                                else{
                                                  final respuesta = await apiPrestamos.pagos(widget.datos.data[widget.indexCliente].debe[index].idPrestamo, widget.datos.data[widget.indexCliente].debe[index].variantId, double.parse(_controladorCobrar[index].text),  "cobro",providerUsuario.token);

                                                if(respuesta.statusCode == 200){
                                                  EasyLoading.dismiss();

                                                  final dataRefresh = await ApiPrestamos().getHistorico(context,providerUsuario.token);



                                                  Navigator.pushReplacement(
                                                     context,
                                                     MaterialPageRoute(
                                                         builder: (BuildContext context) => PrestamoHistoricoTablet(datos: dataRefresh, indexCliente: widget.indexCliente)));
                                                }
                                                else {
                                                  EasyLoading.dismiss();

                                                  await FlutterPlatformAlert.showAlert(
                                                    windowTitle: '¡Oh no!',
                                                    text: 'Ocurrio un error al cobrar el producto',
                                                    alertStyle: AlertButtonStyle.ok,
                                                    iconStyle: IconStyle.information,
                                                  );                                            }
                                                }

                                              }

                                              else{
                                                EasyLoading.dismiss();

                                                await FlutterPlatformAlert.showAlert(
                                                  windowTitle: '¡Ups!',
                                                  text: 'No puedes cobrar mas de lo que te debe',
                                                  alertStyle: AlertButtonStyle.ok,
                                                  iconStyle: IconStyle.information,
                                                );

                                                _controladorCobrar[index].text = "";
                                              }

                                            },
                                            child:  TextoAutoajustable(texto: "Cobrar",colorTexto: Colors.white, tamanoTexto: 0.3,),
                                            style: ElevatedButton.styleFrom(
                                              elevation: 1,
                                              primary: Colors.green,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                }, separatorBuilder: (BuildContext context, int index) {
                                return Divider();
                              },
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: SizedBox(
                                height: Pantalla(context).altoDisp(0.5),
                                width: Pantalla(context).anchoDisp(7),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    TextoAutoajustable(texto: "Debo", colorTexto: Colors.red, tamanoTexto: 1,),

                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height:Pantalla(context).altoDisp(2) ,
                              width: Pantalla(context).anchoDisp(7),
                              child: ListView.separated(
                                itemCount: widget.datos.data[widget.indexCliente].debo.length,
                                shrinkWrap: true,

                                itemBuilder: (BuildContext context,int index){
                                  return
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: TextoAutoajustable(texto: widget.datos.data[widget.indexCliente].debo[index].item, tamanoTexto: widget.datos.data[widget.indexCliente].debo[index].item.length > 12 ? 0.1 : 0.2,colorTexto: Colors.grey,altoContainer: 0.1,),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(right: 10.0),
                                            child: Row(
                                              children: [
                                                TextoAutoajustable(texto: double.parse(widget.datos.data[widget.indexCliente].debo[index].cantidad).toStringAsFixed(2), tamanoTexto: 0.2,colorTexto: Colors.red,altoContainer: 0.1,),
                                                SizedBox(width: Pantalla(context).anchoDisp(0.1),),
                                                InputGenerico(controlador: _controladorPagar[index], colorLinea: Colors.red,tamanoTexto: 0.2,altoContainer: 0.1,)
                                              ],
                                            ),
                                          ),

                                          SizedBox(
                                            height: Pantalla(context).altoDisp(0.4),
                                            width: Pantalla(context).anchoDisp(2),
                                            child: ElevatedButton(

                                              onPressed: () async {
                                                EasyLoading.show(status: 'Pagando...');


                                                if(double.parse(widget.datos.data[widget.indexCliente].debo[index].cantidad) >= double.parse(_controladorPagar[index].text)){
                                                  //Cliente cli = await  providerSqliteCliente.selectCliente(widget.datos.data[widget.indexCliente].cliente);

                                                  if(double.parse(widget.datos.data[widget.indexCliente].debo[index].cantidad) - double.parse(_controladorPagar[index].text) == 0 && (widget.datos.data[widget.indexCliente].debo.length == 1 && widget.datos.data[widget.indexCliente].debe.length == 0)){
                                                    final respuesta = await apiPrestamos.pagos(widget.datos.data[widget.indexCliente].debo[index].idPrestamo, widget.datos.data[widget.indexCliente].debo[index].variantId, double.parse(_controladorPagar[index].text),  "pagar",providerUsuario.token);

                                                  if(respuesta.statusCode == 200){
                                                    EasyLoading.dismiss();
                                                    providerMenuDashboardTablet.menu = 4;
                                                    Navigator.pop(context);
                                                    }
                                                  else {
                                                    EasyLoading.dismiss();

                                                    await FlutterPlatformAlert.showAlert(
                                                      windowTitle: '¡Oh no!',
                                                      text: 'Ocurrio un error al pagar el producto',
                                                      alertStyle: AlertButtonStyle.ok,
                                                      iconStyle: IconStyle.information,
                                                    );
                                                  }
                                                  }

                                                  else{
                                                    final respuesta = await apiPrestamos.pagos(widget.datos.data[widget.indexCliente].debo[index].idPrestamo, widget.datos.data[widget.indexCliente].debo[index].variantId, double.parse(_controladorPagar[index].text),  "pagar",providerUsuario.token);

                                                  if(respuesta.statusCode == 200){
                                                    EasyLoading.dismiss();

                                                    final dataRefresh = await ApiPrestamos().getHistorico(context,providerUsuario.token);

                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext context) => PrestamoHistoricoTablet(datos: dataRefresh, indexCliente: widget.indexCliente)));
                                                  }
                                                  else {
                                                    EasyLoading.dismiss();

                                                    await FlutterPlatformAlert.showAlert(
                                                      windowTitle: '¡Oh no!',
                                                      text: 'Ocurrio un error al pagar el producto',
                                                      alertStyle: AlertButtonStyle.ok,
                                                      iconStyle: IconStyle.information,
                                                    );
                                                  }
                                                  }


                                                }

                                                else{
                                                  EasyLoading.dismiss();
                                                  await FlutterPlatformAlert.showAlert(
                                                    windowTitle: '¡Ups!',
                                                    text: 'No puedes pagar mas de lo que debes',
                                                    alertStyle: AlertButtonStyle.ok,
                                                    iconStyle: IconStyle.information,
                                                  );

                                                  _controladorCobrar[index].text = "";
                                                }

                                              },
                                              child:  TextoAutoajustable(texto: "Pagar",colorTexto: Colors.white, tamanoTexto: 0.3,),
                                              style: ElevatedButton.styleFrom(
                                                elevation: 1,
                                                primary: Colors.red,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                }, separatorBuilder: (BuildContext context, int index) {
                                return Divider();
                              },
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}
