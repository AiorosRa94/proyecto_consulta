import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_consulta/APIs/prestamos/apiPrestamos.dart';
import 'package:proyecto_consulta/estructurasDatos/prestamo/prestamosHistoricoJSON.dart';
import 'package:proyecto_consulta/paginasTablet/fragmentos/prestamosTablet/prestamoHistoricoTablet.dart';
import 'package:proyecto_consulta/providers/providerUsuario/providerUsuario.dart';
import 'package:proyecto_consulta/recursos/responsivo/pantalla.dart';
import 'package:proyecto_consulta/widget/imagenes/imagenContenedor.dart';
import 'package:proyecto_consulta/widget/textos/textoContainer.dart';

class PrestamosQuienesTablet extends StatelessWidget {
  const PrestamosQuienesTablet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var providerUsuario = Provider.of<ProviderUsuario>(context);

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ImagenContainer(imagen: "assets/prestamos.png",altoContainer: 3),
            SizedBox(
              height: Pantalla(context).altoDisp(6),
              width: Pantalla(context).anchoDisp(8),

              child: Card(
                color: Colors.white,
                child: FutureBuilder<PrestamosHistoricoJson>(
                  future: ApiPrestamos().getHistorico(context,providerUsuario.token), // a previously-obtained Future<String> or null
                  builder: (BuildContext context, AsyncSnapshot<PrestamosHistoricoJson> snapshot) {
                    List<Widget> children;
                    if (snapshot.hasData) {
                      children = <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: TextoContainer(texto: "Clientes recientes", anchoContainer: 8, altoContainer: 0.3, tamanoTexto: 0.3,colorTexto: Colors.grey,),
                        ),
                        ListView.separated(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                            itemCount: snapshot.data!.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Icon(FontAwesomeIcons.solidUserCircle,size: Pantalla(context).altoDisp(0.6),),
                                title: TextoContainer(texto: snapshot.data!.data[index].cliente, pesoTexto: FontWeight.bold,tamanoTexto: 0.3, alineacionTexto: TextAlign.start,altoContainer: 0.5,paddingTexto: 0,),
                                subtitle: TextoContainer(texto: snapshot.data!.data[index].contactoCliente,tamanoTexto: 0.25,colorTexto: Colors.grey, alineacionTexto: TextAlign.start,altoContainer: 0.3,paddingTexto: 0,),
                              onTap: (){
                                  print("hola");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  PrestamoHistoricoTablet(datos: snapshot.data!, indexCliente: index)),
                                );                              },
                              );
                            },
                          separatorBuilder: (BuildContext context, int index) {
                             return Divider();
                          },

                    )
                      ];
                    }
                    else if (snapshot.hasError) {
                      children = <Widget>[
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text('Error: ${snapshot.error}'),
                        )
                      ];
                    }
                    else {
                      children = const <Widget>[
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(color: Colors.deepPurple,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Cargando'),
                        )
                      ];
                    }
                    return Column(
                      children: children,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
