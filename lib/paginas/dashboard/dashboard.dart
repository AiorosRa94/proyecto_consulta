import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phoenix_native/phoenix_native.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_consulta/APIs/clientes/ApiClientes.dart';
import 'package:proyecto_consulta/APIs/productos/ApiProductos.dart';
import 'package:proyecto_consulta/paginasTablet/dashboardTablet/dashboardTablet.dart';
import 'package:proyecto_consulta/providers/providerMenuDashboard/providerMenuDashboard.dart';
import 'package:proyecto_consulta/providers/providerNavBar/providerNavBar.dart';
import 'package:proyecto_consulta/providers/providerPermisos/providerStorage.dart';
import 'package:proyecto_consulta/providers/providerUsuario/providerUsuario.dart';
import 'package:proyecto_consulta/recursos/responsivo/pantalla.dart';
import 'package:proyecto_consulta/widget/textos/textoAutoajustable.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

  Future _getPermisosStorage(ProviderStorage stg) async {
    if (await Permission.storage.request().isGranted) {
      stg.permisoStorage = true;
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      stg.permisoStorage = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var providerMenu = Provider.of<ProviderNavBar>(context);
    var providerMenuDashboard = Provider.of<ProviderMenuDashboard>(context);
    var providerStorage = Provider.of<ProviderStorage>(context);
    var providerUsuario = Provider.of<ProviderUsuario>(context);

    return OrientationBuilder(builder: (context, orientation) {
      print("Orientacion : ${orientation.toString()}");
      if (orientation == Orientation.landscape) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardTablet()),
          );
        });
      }
      return WillPopScope(
        onWillPop: () {
          //trigger leaving and use own data
          switch (providerMenuDashboard.menu) {
            case 5:
              providerMenuDashboard.menu = 4;
              break;

            default:
              print("esta en el menu: ${providerMenuDashboard.menu}");
              providerMenuDashboard.menu = 0;
              break;
          }
          providerMenuDashboard.menu = 0;
          Provider.of<ApiProductos>(context, listen: false).getProductos(context, providerUsuario.token);
          Provider.of<ApiClientes>(context, listen: false).getClientes(context, providerUsuario.token);
          //we need to return a future
          return Future.value(false);
        },
        child: Scaffold(
          body: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/background_dashboard.png"), fit: BoxFit.fill),
            ),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        providerMenuDashboard.menu == 0
                            ? IconButton(
                                onPressed: () {},
                                icon: Icon(FontAwesomeIcons.ellipsis, color: Colors.white, size: Pantalla(context).altoDisp(0.3)),
                              )
                            : IconButton(
                                onPressed: () {
                                  Provider.of<ApiProductos>(context, listen: false).getProductos(context, providerUsuario.token);
                                  Provider.of<ApiClientes>(context, listen: false).getClientes(context, providerUsuario.token);
                                  switch (providerMenuDashboard.menu) {
                                    case 5:
                                      providerMenuDashboard.menu = 4;
                                      break;

                                    default:
                                      print("esta en el menu: ${providerMenuDashboard.menu}");
                                      providerMenuDashboard.menu = 0;
                                      break;
                                  }
                                },
                                icon: Icon(FontAwesomeIcons.arrowLeft, color: Colors.white, size: Pantalla(context).altoDisp(0.3)),
                              ),
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text("Cerrar sesión"),
                              value: 1,
                              onTap: () async {
                                EasyLoading.show(status: 'Saliendo...');

                                PhoenixNative.restartApp();
                              },
                            )
                          ],
                          icon: Icon(FontAwesomeIcons.solidCircleUser, color: Colors.white, size: Pantalla(context).altoDisp(0.3)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: Pantalla(context).altoDisp(0.3),
                          ),
                          providerMenu.pantalla,
                          Padding(
                            padding: EdgeInsets.only(top: Pantalla(context).altoDisp(0.3)),
                            child: SizedBox(
                              height: Pantalla(context).altoDisp(0.6),
                              width: Pantalla(context).anchoDisp(5),
                              child: ElevatedButton(
                                onPressed: () async {
                                  print("Descargando...");
                                  await _getPermisosStorage(providerStorage);

                                  if (providerStorage.permisoStorage) {
                                    _launchURL(providerUsuario.token);
                                  } else {
                                    print("No tienes permisos");
                                  }
                                },
                                child: TextoAutoajustable(
                                  texto: "Historial",
                                  colorTexto: Colors.white,
                                  tamanoTexto: 0.6,
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 1,
                                  backgroundColor: Colors.purple.shade300,
                                  side: BorderSide(width: 1.0, color: Colors.purple.shade300),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.home,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidCompass),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidClock),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidUser),
                label: '',
              ),
            ],
            currentIndex: providerMenu.menu,
            selectedItemColor: Colors.purple.shade300,
            unselectedItemColor: Colors.grey.shade300,
            onTap: (index) => providerMenu.menu = index,
          ),
        ),
      );
    });
  }

  void _launchURL(String token) async {
    EasyLoading.show(status: 'Creando PDF...');

    DateTime now = DateTime.now();
    print("TOKEEEEEN: $token");
    String formatoFecha = DateFormat('yyyy-MM-dd').format(now);

    Directory root = await getApplicationDocumentsDirectory();
    String directoryPath = root.path + '/historial';
    await Directory(directoryPath).create(recursive: true);
    String filePath = '$directoryPath/historial$formatoFecha.pdf';

    print(filePath);

    HttpClient client = new HttpClient();
    client.getUrl(Uri.parse("http://187.188.96.87/APIS/apiLoyVerseConsultora/index.php/reporte?fecha=${formatoFecha}")).then((HttpClientRequest request) {
      request.headers.add("Authorization", "Digest $token");
      return request.close();
    }).then((HttpClientResponse response) {
      response.pipe(new File(filePath).openWrite());
      OpenFile.open(filePath);
      EasyLoading.dismiss();
    });
  }
}
