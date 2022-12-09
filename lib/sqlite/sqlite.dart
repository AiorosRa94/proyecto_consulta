import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class Sqlite {

  static  Future<Database>? _db;

  static Future<Database> getDB(){
    _db ??= _initDB();

    return _db!;
  }

  static Future<Database> _initDB() async {
    final db = await openDatabase(
    join(await getDatabasesPath(), "productos.db"),
      version: 1,
      onCreate: _onCreate,
    );

    return db;
  }

  static _onCreate(Database db, int  version) async{
    await db.execute("CREATE TABLE productos(nombre TEXT NOT NULL, varianteId TEXT NOT NULL PRIMARY KEY, enStock TEXT NOT NULL)");
    await db.execute("CREATE TABLE clientes(id TEXT NOT NULL PRIMARY KEY, agente TEXT NOT NULL, nombre TEXT NOT NULL,proveedor TEXT NOT NULL, numeroTelefono TEXT NOT NULL)");
  }


}