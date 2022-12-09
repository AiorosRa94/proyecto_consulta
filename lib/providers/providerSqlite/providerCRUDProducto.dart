import 'package:flutter/material.dart';
import 'package:proyecto_consulta/sqlite/modelos/producto.dart';
import 'package:proyecto_consulta/sqlite/sqlite.dart';
import 'package:sqflite/sqflite.dart';

class ProviderCRUDProducto with ChangeNotifier{
List<Producto> _productos = [];

List<Producto> get productos =>[..._productos];

List<String> _listaSugerencias = [];

List<String> get listaSugerencias =>_listaSugerencias;


  Future<void> actualizarListaProductos() async{

  final Database db = await Sqlite.getDB();

  final List<Map<String,dynamic>> maps = await  db.query("productos");
  
  _productos = List.generate(maps.length, (i){
    return Producto(
        id: maps[i]['id'],
        nombre: maps[i]['nombre'],
        varianteId: maps[i]['varianteId'],
        enStock: maps[i]['enStock']
    );
  }
  );
  notifyListeners();
}

  Future<void> nuevoProducto(Producto producto) async {
    final Database db = await Sqlite.getDB();

    await db.insert("productos",
      producto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> actualizarProducto(Producto producto) async {
    final Database db = await Sqlite.getDB();

    await db.update("productos",
      producto.toMap(),
      where: "nombre=?",
      whereArgs: [producto.nombre]
    );
  }

  Future<Producto> selectProducto(String nombreProducto) async {

  late  Producto prod ;

    final Database db = await Sqlite.getDB();

    final List<Map<String,dynamic>> maps =  await db.rawQuery('SELECT * FROM productos WHERE nombre=?', ['${nombreProducto}']);

    prod =
       Producto(
          id: maps[0]['id'] ?? 0,
          nombre: maps[0]['nombre'] ?? "",
          varianteId: maps[0]['varianteId'] ?? "",
          enStock: maps[0]['enStock'] ?? ""
      );



  return prod;
}

  Future<void> selectProductoSugerencias() async {

  final Database db = await Sqlite.getDB();

  final List<Map<String,dynamic>> maps = await  db.query("productos");

  List<Producto> prod = [];

  prod = List.generate(maps.length, (i){
    return Producto(
        id: maps[i]['id'],
        nombre: maps[i]['nombre'],
        varianteId: maps[i]['varianteId'],
        enStock: maps[i]['enStock']
    );
  });

  _listaSugerencias.clear();
  for (int i = 0; i < prod.length ; i++) {
    //print("VALOR A LISTA : ${Utf8Decoder().convert(prod[i].nombre.codeUnits)}");
    //_listaSugerencias.add(Utf8Decoder().convert(prod[i].nombre.codeUnits));
    print("VALOR A LISTA : ${prod[i].nombre}");
    listaSugerencias.add(prod[i].nombre);
  }

  notifyListeners();

  }



bool _primeraVez = true;

bool get primeraVez => _primeraVez;

set primeraVez(bool nuevoValor) {
  _primeraVez = nuevoValor;
}
}






