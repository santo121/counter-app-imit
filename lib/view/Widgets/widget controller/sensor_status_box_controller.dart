import 'package:flutter/material.dart';

class SensorStatusBoxController with ChangeNotifier {
  bool _flag = true;
  bool switchFlag = false;

  bool get flag => _flag;

  void changeFlag(flag) {
    _flag = flag;
    notifyListeners();
  }
}
