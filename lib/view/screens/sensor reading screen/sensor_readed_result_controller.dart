import 'dart:developer';

import 'package:counter_iot/controller/server/server_controller.dart';
import 'package:flutter/material.dart';

import '../../../model/jn_sensor_model.dart';

class SensorReadResultController with ChangeNotifier {
  final List<ServerController> lnSensorList = [];
  final List<ServerController> jnSensorList = [];
  // final List<JNSensorModel> jnSensorMainCalcList = [];
  // final List<LNSensorModel> lNSensorMainCalcList = [];
  bool addButtonFlag = true;


  void addToLnSensor(ServerController value){
    lnSensorList.add(value);
     notifyListeners();
    log(lnSensorList[0].toString()+"index number from lane sensor controller");
     
  }
  void changeAddButtonFlag(bool val){
    addButtonFlag = val;
     notifyListeners();
    
  }
  void addToJnSensor(ServerController value){
    jnSensorList.add(value);
     notifyListeners();
  }
}
