import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_consulta/APIs/clientes/ApiClientes.dart';
import 'package:proyecto_consulta/APIs/productos/ApiProductos.dart';
import 'package:proyecto_consulta/providers/providerMenuDashboard/providerMenuDashboard.dart';
import 'package:proyecto_consulta/providers/providerSqlite/providerCRUDCliente.dart';
import 'package:proyecto_consulta/providers/providerSqlite/providerCRUDProducto.dart';
import 'package:proyecto_consulta/providers/providerUsuario/providerUsuario.dart';
import 'package:proyecto_consulta/recursos/responsivo/pantalla.dart';
import 'package:proyecto_consulta/widget/imagenes/imagenBoton.dart';
import 'package:proyecto_consulta/widget/textos/textoAutoajustable.dart';
import 'package:proyecto_consulta/widget/textos/textoContainer.dart';

class Menu extends StatelessWidget {
  Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var providerMenuDashboard = Provider.of<ProviderMenuDashboard>(context);
    var providerSQliteProducto = Provider.of<ProviderCRUDProducto>(context);
    var providerSQliteCliente = Provider.of<ProviderCRUDCliente>(context);
    var providerApiProducto = Provider.of<ApiProductos>(context);
    var providerApiCliente = Provider.of<ApiClientes>(context);
    var providerUsuario = Provider.of<ProviderUsuario>(context);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    if (providerApiProducto.cargoProd == false) {
      providerApiProducto.getProductos(context, providerUsuario.token);
      providerApiCliente.getClientes(context, providerUsuario.token);
    }

    List<Widget> cargando() {
      List<Widget> port = [CircularProgressIndicator(), TextoAutoajustable(texto: "Cargando")];
      return port;
    }

    List<Widget> getPort() {
      List<Widget> port = [
        TextoContainer(texto: "Hola! ${providerUsuario.usuario.nombreCliente}", colorTexto: Colors.white, tamanoTexto: Pantalla(context).anchoDisp(0.01), altoContainer: 0.8, anchoContainer: 7),
        TextoContainer(
          texto: "Movimientos",
          colorTexto: Colors.white,
          tamanoTexto: Pantalla(context).anchoDisp(0.012),
          altoContainer: 0.8,
          anchoContainer: 7,
          pesoTexto: FontWeight.bold,
        ),
        GestureDetector(
            onTap: () {
              providerMenuDashboard.menu = 6;
            },
            child: ImagenBoton(urlImg: "assets/cartaReporte.png")),
        GestureDetector(
            onTap: () {
              providerSQliteProducto.selectProductoSugerencias();
              providerSQliteCliente.selectClienteSugerencias();
              providerMenuDashboard.menu = 2;
            },
            child: ImagenBoton(urlImg: "assets/cartaIngresar.png")),
        GestureDetector(
            onTap: () {
              providerSQliteProducto.selectProductoSugerencias();
              providerSQliteCliente.selectClienteSugerencias();
              providerMenuDashboard.menu = 1;
            },
            child: ImagenBoton(urlImg: "assets/cartaSacar.png")),
        GestureDetector(
            onTap: () {
              providerSQliteProducto.selectProductoSugerencias();
              providerSQliteCliente.selectClienteSugerencias();
              providerMenuDashboard.menu = 3;
            },
            child: ImagenBoton(urlImg: "assets/cartaRecuento.png")),
        GestureDetector(
            onTap: () {
              providerSQliteProducto.selectProductoSugerencias();
              providerSQliteCliente.selectClienteSugerencias();
              providerMenuDashboard.menu = 4;
            },
            child: ImagenBoton(urlImg: "assets/cartaPrestamos.png")),
      ];
      return port;
    }

    return Column(
        children:
            // providerRotacion.orientacion == true ?  getPort() : getLands(),
            providerApiProducto.cargoProd == true && providerApiCliente.cargoCli == true ? getPort() : cargando());
  }
}
