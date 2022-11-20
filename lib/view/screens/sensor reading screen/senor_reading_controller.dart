// import 'package:flutter/cupertino.dart';

// // enum SensorType { lnSensor, jnSensor }

// class SensorReadingController with ChangeNotifier {


//   String existingVal="";
//   SensorType? sensorType;
//   bool verified = false;
//  String? sensorId='';
//  int ?sensorCount;
//   // ! TAB count is used for get the count of the selected tab from sensor reading screen
//   int tabCount = 0;
//   SensorReadingController.sn(
//       {required this.sensorType, required this.verified,this.sensorId,required this.sensorCount});

//   void changeSensorType({required SensorType sensorType}) {
//     this.sensorType = sensorType;
//     notifyListeners();
//   }
//   void changeExistingVal(val){
//     existingVal = val;
//     notifyListeners();
//   }
//  void changeSensorId ({required val}){
//   sensorId = val;
//   notifyListeners();
//  }

//   void changeVerification({required bool verified}) {
//     this.verified = verified;
//     notifyListeners();
//   }

//   void changedTabCount(val) {
//     tabCount = val;
//     notifyListeners();
//   }

//   SensorReadingController();



  
// }
