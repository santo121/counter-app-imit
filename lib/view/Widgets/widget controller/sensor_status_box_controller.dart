import 'package:flutter/material.dart';

class SensorStatusBoxController with ChangeNotifier {
  bool flag;
  bool switchFlag;
  String ?vehicleNumber;
  // bool getflag => _flag;
  // bool get switchFlag => _switchFlag;

  SensorStatusBoxController({required this.flag,required this.switchFlag, this.vehicleNumber});

 

  void changeFlag(flag) {
    flag = flag;
    notifyListeners();
  }
  void changeSwitchFlag(flag){
    switchFlag = flag;
    notifyListeners();
  }
}
 