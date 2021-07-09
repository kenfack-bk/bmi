import 'package:bmi/models/model.dart';
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths
import 'dart:io';
import 'package:sqflite/sqflite.dart';

class DBService {
  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentDirectory.path, "Bim.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("""
                  CREATE TABLE Bim(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  height REAL,
                  weight REAL,
                  bim REAL,
                  category TEXT,
                  date TEXT)""");
    });
  }

  Future<int> addNewBimMeasure(BimMeasure bimMeasure) async {
    final db = await initDB();
    return db.insert(BimMeasure.tabbleName, bimMeasure.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<BimMeasure>> fetchBimMeasures() async {
    final db = await initDB();
    final maps = await db.query(BimMeasure.tabbleName);
    return List.generate(maps.length, (i) {
      return BimMeasure(
        id: maps[i]['id'] as int,
        height: maps[i]['height'] as double,
        weight: maps[i]['weight'] as double,
        bim: maps[i]['bim'] as double,
        category: maps[i]['category'] as String,
        date: DateTime.parse(maps[i]['date'] as String),
      );
    });
  }
}
