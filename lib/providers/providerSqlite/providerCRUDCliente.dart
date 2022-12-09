import 'package:flutter/material.dart';
import 'package:proyecto_consulta/sqlite/modelos/cliente.dart';
import 'package:proyecto_consulta/sqlite/sqlite.dart';
import 'package:sqflite/sqflite.dart';

class ProviderCRUDCliente with ChangeNotifier{
  List<Cliente> _clientes = [];

  List<Cliente> get clientes =>[..._clientes];

  List<String> _listaSugerenciasClientes = [];

  List<String> get listaSugerencias =>_listaSugerenciasClientes;


  Future<void> actualizarListaClientes() async{

    final Database db = await Sqlite.getDB();

    final List<Map<String,dynamic>> maps = await  db.query("clientes");
    _clientes = List.generate(maps.length, (i){
      return Cliente(
          id: maps[i]['id'],
          agente: maps[i]['agente'],
          nombre: maps[i]['nombre'],
          proveedor: maps[i]['proveedor'],
          numeroTelefono: maps[i]['numeroTelefono']
      );
    }
    );
    notifyListeners();
  }

  Future<void> nuevoCliente(Cliente cliente) async {
    final Database db = await Sqlite.getDB();

    await db.insert("clientes",
      cliente.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> actualizarCliente(Cliente cliente) async {
    final Database db = await Sqlite.getDB();

    await db.update("clientes",
        cliente.toMap(),
        where: "id=?",
        whereArgs: [cliente.id]
    );
  }

  Future<Cliente> selectCliente(String nombreCliente) async {

    late  Cliente cli ;

    final Database db = await Sqlite.getDB();

    final List<Map<String,dynamic>> maps =  await db.rawQuery('SELECT * FROM clientes WHERE nombre=?', ['${nombreCliente}']);

    cli =
        Cliente(
            id: maps[0]['id'],
            agente: maps[0]['agente'] ?? "Sin nombre de agente",
            nombre: maps[0]['nombre'] ?? "Sin nombre",
            proveedor: maps[0]['proveedor'] ?? "Sin nombre de proveedor",
            numeroTelefono: maps[0]['numeroTelefono'] ?? "00 0000 0000"
        );



    return cli;
  }

  Future<void> selectClienteSugerencias() async {

    final Database db = await Sqlite.getDB();

    final List<Map<String,dynamic>> maps = await  db.query("clientes");

    List<Cliente> cli = [];

    cli = List.generate(maps.length, (i){
      return Cliente(
          id: maps[i]['id'],
          agente: maps[i]['agente'],
          nombre: maps[i]['nombre'],
          proveedor: maps[i]['proveedor'],
          numeroTelefono: maps[i]['numeroTelefono']
      );
    });

    _listaSugerenciasClientes.clear();
    for (int i = 0; i < cli.length ; i++) {
      //print("VALOR A LISTA : ${Utf8Decoder().convert(prod[i].nombre.codeUnits)}");
      //_listaSugerencias.add(Utf8Decoder().convert(prod[i].nombre.codeUnits));
      print("VALOR A LISTA : ${cli[i].nombre}");
      listaSugerencias.add(cli[i].nombre);
    }

    notifyListeners();

  }



  bool _primeraVez = true;

  bool get primeraVez => _primeraVez;

  set primeraVez(bool nuevoValor) {
    _primeraVez = nuevoValor;
  }
}






