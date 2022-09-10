import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/db_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB('counter.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }


final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';


  Future<void> _createDb(Database val, int id) async {
    // Table for sensors
    await val.execute(
        'CREATE TABLE SensorData(id INTEGER PRIMARY KEY,sensorId TEXT,sensorType TEXT,sensorSlno TEXT,sensorCode  TEXT)');

    //Table for lane occupancy
    await val.execute(
        'CREATE TABLE LaneOccupancy(occuId INTEGER PRIMARY KEY,occuVehicle TEXT,occuLaneSlno TEXT,occuWorkMode TEXT,occuEndDt  TEXT)');

    //Table for RF tags

    await val.execute(
        'CREATE TABLE RfTags(tagId INTEGER PRIMARY KEY,tagCode TEXT,tagName TEXT,tagStatus TEXT)');

    //Table for readings

    await val.execute(
        'CREATE TABLE Readings(readId INTEGER PRIMARY KEY,readOccu TEXT,readWMode TEXT,occuWorkMode TEXT,occuEndDt  TEXT)');
  }

  Future<void> addValuesToAllFields(SensorModel model) async {
    final db = await instance.database;
    int id = await db!.insert("SensorData", model.toJson());

    log(id.toString());
  }

  Future<void> close() async {
    final db = await instance.database;
    db!.close();
  }

  Future<SensorModel> readSensor(int id) async {
    final db = await instance.database;

    final maps = await db!.query(
      "SensorData",
    );

    if (maps.isNotEmpty) {
      return SensorModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<SensorModel>> readAllSensor() async {
    final db = await instance.database;

    // final orderBy = '${NoteFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    // final result = await db.query(tableNotes, orderBy: orderBy);
    final result = await db!.query("SensorData");
    final toList = result.map((json) => SensorModel.fromJson(json)).toList();
    for (var i = 0; i < toList.length; i++) {
      log("data data data ${toList[i].sensorId}");
    }

    return toList;
  }
}
