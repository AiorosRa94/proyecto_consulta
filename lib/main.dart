import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_consulta/APIs/clientes/ApiClientes.dart';
import 'package:proyecto_consulta/APIs/productos/ApiProductos.dart';
import 'package:proyecto_consulta/paginas/login/login.dart';
import 'package:proyecto_consulta/paginasTablet/loginTablet/loginTablet.dart';
import 'package:proyecto_consulta/providers/providerIngresar/providerIngresar.dart';
import 'package:proyecto_consulta/providers/providerMenuDashboard/providerMenuDashboard.dart';
import 'package:proyecto_consulta/providers/providerMenuDashboard/providerMenuDashboardTablet.dart';
import 'package:proyecto_consulta/providers/providerNavBar/providerNavBar.dart';
import 'package:proyecto_consulta/providers/providerNavBar/providerNavBarTablet.dart';
import 'package:proyecto_consulta/providers/providerPermisos/providerStorage.dart';
import 'package:proyecto_consulta/providers/providerPrestamo/providerPrestamo.dart';
import 'package:proyecto_consulta/providers/providerRecuento/providerRecuento.dart';
import 'package:proyecto_consulta/providers/providerReporte/providerReporte.dart';
import 'package:proyecto_consulta/providers/providerRotacion/providerRotacion.dart';
import 'package:proyecto_consulta/providers/providerSacar/providerSacar.dart';
import 'package:proyecto_consulta/providers/providerSqlite/providerCRUDCliente.dart';
import 'package:proyecto_consulta/providers/providerSqlite/providerCRUDProducto.dart';
import 'package:proyecto_consulta/providers/providerUsuario/providerUsuario.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersive
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderNavBar>(create: (context) => ProviderNavBar()),
        ChangeNotifierProvider<ProviderNavBarTablet>(create: (context) => ProviderNavBarTablet()),
        ChangeNotifierProvider<ProviderSacar>(create: (context) => ProviderSacar()),
        ChangeNotifierProvider<ProviderIngresar>(create: (context) => ProviderIngresar()),
        ChangeNotifierProvider<ProviderRecuento>(create: (context) => ProviderRecuento()),
        ChangeNotifierProvider<ProviderMenuDashboard>(create: (context) => ProviderMenuDashboard()),
        ChangeNotifierProvider<ProviderMenuDashboardTablet>(create: (context) => ProviderMenuDashboardTablet()),
        ChangeNotifierProvider<ProviderPrestamo>(create: (context) => ProviderPrestamo()),
        ChangeNotifierProvider<ProviderCRUDProducto>(create: (context) => ProviderCRUDProducto()),
        ChangeNotifierProvider<ProviderCRUDCliente>(create: (context) => ProviderCRUDCliente()),
        ChangeNotifierProvider<ProviderRotacion>(create: (context) => ProviderRotacion()),
        ChangeNotifierProvider<ProviderStorage>(create: (context) => ProviderStorage()),
        ChangeNotifierProvider<ApiProductos>(create: (context) => ApiProductos()),
        ChangeNotifierProvider<ApiClientes>(create: (context) => ApiClientes()),
        ChangeNotifierProvider<ProviderUsuario>(create: (context) => ProviderUsuario()),
        ChangeNotifierProvider<ProviderReporte>(create: (context) => ProviderReporte()),
      ],
      child: MaterialApp(
        title: 'Consulta',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: OrientationBuilder(builder: (context, orientation) {
         return orientation == Orientation.portrait ? Login() : LoginTablet();
        }
        ),
          builder: EasyLoading.init()
      ),
    );
  }
}
