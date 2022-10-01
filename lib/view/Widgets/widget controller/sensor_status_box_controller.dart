import 'package:flutter/material.dart';

class SensorStatusBoxController with ChangeNotifier {

  bool flag = false;
  bool switchFlag = false;
  String vehicleNumber = "";

  
  SensorStatusBoxController.ln({required this.flag,required this.switchFlag,required this.vehicleNumber});
  SensorStatusBoxController.jn({required this.flag,required this.switchFlag});
  SensorStatusBoxController();

  void changeFlag(flag) {
    flag = flag;
    notifyListeners();
  }
  void changeSwitchFlag(flag){
    switchFlag = flag;
    notifyListeners();
  }
  void changeVehicleNumber(number){
    vehicleNumber = number;
    notifyListeners();
  }
}
 