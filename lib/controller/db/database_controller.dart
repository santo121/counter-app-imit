import 'dart:developer';
import 'package:counter_iot/DB/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/db_model.dart';

class DatabaseController with ChangeNotifier {
  late Database _db;
  late List<SensorModel> deviceModel;

  
  bool isLoading = false;


  
  
  
   Future refreshSensor() async {
    isLoading = true;
    deviceModel = await DatabaseHelper.instance.readAllSensor();
    // print(deviceModel[10].sensorCode);
    isLoading = true;
    notifyListeners();
  }
  
  
  
  
  
  
  
  
  
  
  Future<void> initializeDataBase() async {
    final dataBase = await openDatabase('deviceData.db', version: 1,
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE SensorData(id INTEGER PRIMARY KEY,sensorId TEXT,sensorType TEXT,sensorSlno TEXT,sensorCode  TEXT)');
      // await db.execute('CREATE TABLE DeviceData(id INTEGER PRIMARY KEY,name TEXT,)');
    });
    _db=dataBase;
    log("data from initialization ${_db.toString()}");
    notifyListeners();
  }

  Future<void> addSensorData() async {
    int insertedId = await _db.rawInsert(
        'INSERT INTO SensorData(sensorId, sensorType, sensorSlno, sensorCode) VALUES("some name", "1234", "456.789", "456.789")');
    log("Inserted id:$insertedId");
  }

  // notifyListeners();

  Future<void> getSensorData() async {
    final _value = await _db.rawQuery('SELECT * FROM SensorData');

    log(_value.toString());
    notifyListeners();
  }
}
