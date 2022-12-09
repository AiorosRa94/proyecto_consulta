import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_consulta/APIs/clientes/ApiClientes.dart';
import 'package:proyecto_consulta/APIs/productos/ApiProductos.dart';
import 'package:proyecto_consulta/providers/providerMenuDashboard/providerMenuDashboardTablet.dart';
import 'package:proyecto_consulta/providers/providerSqlite/providerCRUDCliente.dart';
import 'package:proyecto_consulta/providers/providerSqlite/providerCRUDProducto.dart';
import 'package:proyecto_consulta/providers/providerUsuario/providerUsuario.dart';
import 'package:proyecto_consulta/recursos/responsivo/pantalla.dart';
import 'package:proyecto_consulta/widget/imagenes/imagenBoton.dart';
import 'package:proyecto_consulta/widget/textos/textoAutoajustable.dart';
import 'package:proyecto_consulta/widget/textos/textoContainer.dart';

class MenuTablet extends StatelessWidget {
   MenuTablet({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var providerMenuDashboardTablet = Provider.of<ProviderMenuDashboardTablet>(context);
    var providerSQliteProducto = Provider.of<ProviderCRUDProducto>(context);
    var providerSQliteCliente = Provider.of<ProviderCRUDCliente>(context);
    var providerApiProducto = Provider.of<ApiProductos>(context);
    var providerApiCliente = Provider.of<ApiClientes>(context);
    var providerUsuario = Provider.of<ProviderUsuario>(context);

    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersive
    );

    if(providerApiProducto.cargoProd == false){
      providerApiProducto.getProductos(context,providerUsuario.token);
      providerApiCliente.getClientes(context,providerUsuario.token);
    }

    List<Widget> cargando() {
      List<Widget> port = [
        CircularProgressIndicator(),
        TextoAutoajustable(texto: "Cargando")
      ];
      return port;
    }

    List<Widget> getPort() {
      List<Widget> port = [
        TextoContainer(texto: "Hola! ${providerUsuario.usuario.nombreCliente}",
            colorTexto: Colors.white,
            tamanoTexto: 0.4,
            altoContainer: 0.4,
            anchoContainer: 7),
        TextoContainer(texto: "Movimientos",
          colorTexto: Colors.white,
          tamanoTexto: 0.4,
          altoContainer: 0.4,
          anchoContainer: 7,
          pesoTexto: FontWeight.bold,),

        SizedBox(
          height: Pantalla(context).altoDisp(3),
          width: Pantalla(context).anchoDisp(9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () {
                    providerSQliteProducto.selectProductoSugerencias();
                    providerSQliteCliente.selectClienteSugerencias();
                    providerMenuDashboardTablet.menu = 2;
                  },
                  child: ImagenBoton(urlImg: "assets/cartaIngresar.png" ,altoDisp: 3, anchoDisp: 3,)
              ),
              GestureDetector(
                  onTap: () {
                    providerSQliteProducto.selectProductoSugerencias();
                    providerSQliteCliente.selectClienteSugerencias();
                    providerMenuDashboardTablet.menu = 1;
                  },
                  child: ImagenBoton(urlImg: "assets/cartaSacar.png",altoDisp: 3, anchoDisp: 3)
              ),
            ],
          ),
        ),
        SizedBox(
          height: Pantalla(context).altoDisp(3),
          width: Pantalla(context).anchoDisp(9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () {
                    providerSQliteProducto.selectProductoSugerencias();
                    providerSQliteCliente.selectClienteSugerencias();
                    providerMenuDashboardTablet.menu = 3;
                  },
                  child: ImagenBoton(urlImg: "assets/cartaRecuento.png",altoDisp: 3, anchoDisp: 3,)
              ),
              GestureDetector(
                  onTap: () {
                    providerSQliteProducto.selectProductoSugerencias();
                    providerSQliteCliente.selectClienteSugerencias();
                    providerMenuDashboardTablet.menu = 4;
                  },
                  child: ImagenBoton(urlImg: "assets/cartaPrestamos.png",altoDisp: 3, anchoDisp: 3,)
              ),
            ],
          ),
        ),

      ];
      return port;
    }



       return Center(
         child: Column(
            children:
           // providerRotacion.orientacion == true ?  getPort() : getLands(),
            providerApiProducto.cargoProd == true && providerApiCliente.cargoCli == true?
             getPort() : cargando()
          ),
       );

      }

}
