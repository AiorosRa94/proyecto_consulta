import 'dart:io';
import 'package:calender_picker/calender_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_consulta/providers/providerReporte/providerReporte.dart';
import 'package:proyecto_consulta/widget/inputs/inputGenerico.dart';
import '../../../providers/providerPermisos/providerStorage.dart';
import '../../../providers/providerUsuario/providerUsuario.dart';
import '../../../recursos/responsivo/pantalla.dart';
import '../../../widget/textos/textoAutoajustable.dart';

class Reporte extends StatelessWidget {
  const Reporte({Key? key}) : super(key: key);

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
    var providerUsuario = Provider.of<ProviderUsuario>(context);
    var providerStorage = Provider.of<ProviderStorage>(context);
    var providerFecha = Provider.of<ProviderReporte>(context);

    TextEditingController controladorPorcentaje = TextEditingController();

    return Column(
      children: [
        SizedBox(
          height: Pantalla(context).altoDisp(2.8),
        ),
        TextoAutoajustable(
          texto: "${getMes(providerFecha.fechaSeleccion.month) ?? ""} - ${providerFecha.fechaSeleccion.day}",
          alineacionTexto: TextAlign.start,
          altoContainer: 0.1,
          anchoContainer: 10,
        ),
        CalenderPicker(
          providerFecha.fechaReporte,
          width: Pantalla(context).anchoDisp(2),
          height: Pantalla(context).altoDisp(1),
          daysCount: 31,
          locale: "es_MX",
          initialSelectedDate: providerFecha.fechaReporte,
          selectionColor: Colors.black,
          selectedTextColor: Colors.white,
          onDateChange: (date) {
            print("Fecha Seleccionada: $date");
            providerFecha.fechaSeleccion = date;
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TextoAutoajustable(
            texto: "Seleccione porcentaje a descargar",
            tamanoTexto: 0.5,
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
              height: Pantalla(context).altoDisp(0.2),
              width: Pantalla(context).anchoDisp(1),
              child: InputGenerico(
                controlador: controladorPorcentaje,
                alineacionTexto: TextAlign.center,
                tipoTeclado: TextInputType.number,
              )),
          SizedBox(
              height: Pantalla(context).altoDisp(1.5),
              width: Pantalla(context).anchoDisp(2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        int valorAct = int.parse(controladorPorcentaje.text == "" ? "0" : controladorPorcentaje.text);
                        if (valorAct != 100) {
                          valorAct++;
                        }
                        controladorPorcentaje.text = "$valorAct";
                      },
                      icon: Icon(Icons.arrow_drop_up, size: Pantalla(context).altoDisp(0.5))),
                  IconButton(
                      onPressed: () {
                        int valorAct = int.parse(controladorPorcentaje.text == "" ? "0" : controladorPorcentaje.text);
                        if (valorAct != 0) {
                          valorAct--;
                        }
                        controladorPorcentaje.text = "$valorAct";
                      },
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: Pantalla(context).altoDisp(0.5),
                      )),
                ],
              )),
        ]),
        Padding(
          padding: EdgeInsets.only(top: Pantalla(context).altoDisp(0.3)),
          child: SizedBox(
            height: Pantalla(context).altoDisp(0.5),
            width: Pantalla(context).anchoDisp(5),
            child: ElevatedButton(
              onPressed: () async {
                print("Descargando...");
                await _getPermisosStorage(providerStorage);

                if (providerStorage.permisoStorage) {
                  _launchURL(providerUsuario.token, providerFecha.fechaSeleccion, controladorPorcentaje.text);
                } else {
                  print("No tienes permisos");
                }
              },
              child: TextoAutoajustable(
                texto: "Descargar reporte",
                colorTexto: Colors.white,
                tamanoTexto: 0.6,
              ),
              style: ElevatedButton.styleFrom(
                elevation: 1,
                primary: Colors.purple.shade300,
                side: BorderSide(width: 1.0, color: Colors.purple.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _launchURL(String token, DateTime fecha, String porcentaje) async {
    EasyLoading.show(status: 'Creando Reporte...');

    print("TOKEEEEEN: $token");
    String formatoFecha = DateFormat('yyyy-MM-dd').format(fecha);

    Directory root = await getApplicationDocumentsDirectory();
    String directoryPath = root.path + '/reporte';
    await Directory(directoryPath).create(recursive: true);
    String filePath = '$directoryPath/reporte$fecha.pdf';

    print(filePath);

    HttpClient client = new HttpClient();
    client.getUrl(Uri.parse("http://187.188.113.30/APIS/apiLoyVerseConsultora/index.php/ventas?fecha=$formatoFecha&porcentaje=$porcentaje")).then((HttpClientRequest request) {
      request.headers.add("Authorization", "Digest $token");
      return request.close();
    }).then((HttpClientResponse response) {
      response.pipe(new File(filePath).openWrite());
      OpenFile.open(filePath);
      EasyLoading.dismiss();
    });
  }

  String? getMes(int mes) {
    switch (mes) {
      case 1:
        return "Enero";
      case 2:
        return "Febrero";
      case 3:
        return "Marzon";
      case 4:
        return "Abril";
      case 5:
        return "Mayo";
      case 6:
        return "Junio";
      case 7:
        return "Julio";
      case 8:
        return "Agosto";
      case 9:
        return "Septiembre";
      case 10:
        return "Octubre";
      case 11:
        return "Noviembre";
      case 12:
        return "Diciembre";
    }
  }
}
