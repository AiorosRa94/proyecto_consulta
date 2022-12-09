import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_consulta/APIs/login/apiLogin.dart';
import 'package:proyecto_consulta/estructurasDatos/login/usuarioJSON.dart';
import 'package:proyecto_consulta/paginasTablet/dashboardTablet/dashboardTablet.dart';
import 'package:proyecto_consulta/providers/providerUsuario/providerUsuario.dart';
import 'package:proyecto_consulta/recursos/responsivo/pantalla.dart';
import 'package:proyecto_consulta/widget/imagenes/imagenContenedor.dart';
import 'package:proyecto_consulta/widget/inputs/inputGenerico.dart';
import 'package:proyecto_consulta/widget/textos/textoAutoajustable.dart';
import 'package:proyecto_consulta/widget/textos/textoContainer.dart';

class LoginTablet extends StatelessWidget {
  LoginTablet({Key? key}) : super(key: key);
  final _llaveFormulario = GlobalKey<FormState>();
  TextEditingController controladorUsuario = new TextEditingController();
  TextEditingController controladorcontrasena = new TextEditingController();

  ApiLogin login = ApiLogin();

  @override
  Widget build(BuildContext context) {
    var providerUsr = Provider.of<ProviderUsuario>(context);

    print("LOGIN TABLET");
    return Scaffold(
        body: DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/background.png"), fit: BoxFit.fill),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ImagenContainer(
                  imagen: "assets/logoBlanco.png",
                  altoContainer: 2,
                ),
              ),
              TextoAutoajustable(
                texto: "Consulta.com.co",
                colorTexto: Colors.white,
                pesoTexto: FontWeight.bold,
                tamanoTexto: 0.3,
              ),

              Form(
                  key: _llaveFormulario,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: Pantalla(context).altoDisp(0.3)),
                        child: TextoContainer(
                          texto: "Bienvenido",
                          colorTexto: Colors.white,
                          pesoTexto: FontWeight.bold,
                          tamanoTexto: 0.4,
                          altoContainer: 1,
                          anchoContainer: 8,
                          paddingTexto: 0,
                        ),
                      ),
                      InputGenerico(
                        controlador: controladorUsuario,
                        altoContainer: 1,
                        anchoContainer: 8,
                        hint: "usuario",
                        tamanoTexto: 0.4,
                        colorHint: Colors.white,
                        colorTexto: Colors.white,
                        colorLinea: Colors.grey.shade300,
                      ),
                      SizedBox(
                        height: Pantalla(context).altoDisp(0.1),
                      ),
                      InputGenerico(
                        controlador: controladorcontrasena,
                        altoContainer: 1,
                        anchoContainer: 8,
                        tamanoTexto: 0.4,
                        hint: "Contraseña",
                        colorHint: Colors.white,
                        colorTexto: Colors.white,
                        colorLinea: Colors.grey.shade300,
                        esContrasena: true,
                      ),
                    ],
                  )),

              // BOTON INGRESAR
              Padding(
                padding:
                    EdgeInsets.only(top: Pantalla(context).altoDisp(0.6)),
                child: SizedBox(
                  height: Pantalla(context).altoDisp(0.6),
                  width: Pantalla(context).anchoDisp(5),
                  child: ElevatedButton(
                    onPressed: () async {

                      EasyLoading.show(status: 'Entrando...');


                      var log = await login.loginRequest(
                          controladorUsuario.text,
                          controladorcontrasena.text);

                      if (log != null) {
                        providerUsr.usuario = UsuarioJson(
                            clienteId: log.info.user.clienteId,
                            storeId: log.info.user.storeId,
                            nombreCliente: log.info.user.nombreCliente,
                            nombreSucursal: log.info.user.nombreSucursal,
                            user: log.info.user.user);
                        providerUsr.token = log.info.token;
                        print("Token guardado: ${log.info.token}");
                        EasyLoading.dismiss();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardTablet()),
                        );
                      } else {
                        EasyLoading.dismiss();

                        await FlutterPlatformAlert.showAlert(
                          windowTitle: '¡Oh no!',
                          text: 'El usuario o contraseña incorrecta',
                          alertStyle: AlertButtonStyle.ok,
                          iconStyle: IconStyle.information,
                        );

                        controladorcontrasena.text = "";
                      }
                    },
                    child: TextoAutoajustable(
                      texto: "Ingresar",
                      colorTexto: Colors.purple.shade300,
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 1,
                      primary: Colors.white,
                      side: const BorderSide(width: 1.0, color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: TextoAutoajustable(
                    texto: "¿Olvidaste tu contraseña?",
                    colorTexto: Colors.grey.shade100,
                    tamanoTexto: 0.2,
                  )),


              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextoAutoajustable(
                  texto: "Endorsed by Consulta.com.co +57316 319 50 50",
                  colorTexto: Colors.white,
                  tamanoTexto: 0.15,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
