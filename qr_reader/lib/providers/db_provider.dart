import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';

class DBProvider{
  static Database? _database;
  static final DBProvider db = DBProvider._();//constructor privado

  DBProvider._();

  Future<Database> get database async{

    if (_database == null)
      _database = await initDB();
    return _database!;

  }


  Future<Database> initDB() async{
    //path de donde almacena la DB
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path, 'ScansDB.db' );//la extension es importante porque es la de sqlite
    print(path);

    //crear DB
    return await openDatabase(
      path,
      version: 2,
      onOpen: (db){},
      onCreate: (Database db, int version) async{

        //pk autoincrementado
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
            )
        ''');//''' string multilinea

      }
      );

  }

  Future<int> nuevoScanRow( ScanModel nuevoScan) async{

    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    //verificar la DB
    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans( id, tipo, valor)
        VALUES ( $id, '$tipo', '$valor'  )
    ''');

    return res;

  }

  Future<int> nuevoScan( ScanModel nuevoScan) async{
    //verificar la DB
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toMap() );
    print(res);
    return res;
  }

  Future<ScanModel?> getScanById(int i) async{

    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [i]);
    //print(ScanModel.fromMap(res.first));
    //final res = await db.query('Scans'); select sin where
    //print(res);
    return res.isNotEmpty ?
            ScanModel.fromMap(res.first) :
            null;
  }

   Future<List<ScanModel>> getAllScan() async{

    final db = await database;
    final res = await db.query('Scans');
    final info = res.map((e) => ScanModel.fromMap(e)).toList();
    return res.isNotEmpty ?
            info:
            [];
  }

  Future<List<ScanModel>> getScanByTipo(String tipo) async{

    final db = await database;
    final res = await db.rawQuery('''
    SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');
    final info = res.map((e) => ScanModel.fromMap(e)).toList();
    return res.isNotEmpty ?
            info:
            [];
  }

  Future<int> updateScan( ScanModel nuevoScan ) async{
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toMap(), 
                    where: 'id = ?', whereArgs: [nuevoScan.id]);
    //sino se colocan los argumentos where y whereArgs funciona pero elimina todo
    return res;
  }

  Future<int> deleteScan( int id ) async{
    final db = await database;
    final res = await db.delete('Scans',  
                    where: 'id = ?', whereArgs: [id]);
    //sino se colocan los argumentos where y whereArgs funciona pero elimina todo
    return res;
  }

  Future<int> deleteAllScan( ) async{
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');
    return res;
  }

}