import 'package:flutter/cupertino.dart';

enum SensorType { lnSensor, jnSensor }

class SensorReadingController with ChangeNotifier {
// // ! ln sensor list
//  final List<SensorReadingController> lnSensorList = [
//     SensorReadingController.sn(
//         sensorType: SensorType.lnSensor, verified: false),
//     SensorReadingController.sn(
//         sensorType: SensorType.lnSensor, verified: false),
//     SensorReadingController.sn(
//         sensorType: SensorType.lnSensor, verified: false),
//   ];
// // ! jn sensor list

//   final List<SensorReadingController> jnSensorList = [
//     SensorReadingController.sn(
//         sensorType: SensorType.jnSensor, verified: false),
//     SensorReadingController.sn(
//         sensorType: SensorType.jnSensor, verified: false),
//     SensorReadingController.sn(
//         sensorType: SensorType.jnSensor, verified: false),
//   ];


  SensorType sensorType = SensorType.jnSensor;
  bool verified = false;
  int tabCount = 0;
  SensorReadingController.sn(
      {required this.sensorType, required this.verified});

  void changeSensorType({required SensorType sensorType}) {
    this.sensorType = sensorType;
    notifyListeners();
  }

  void changeVerification({required bool verified}) {
    this.verified = verified;
    notifyListeners();
  }

  void changedTabCount(val) {
    tabCount = val;
    notifyListeners();
  }

  SensorReadingController();
}
