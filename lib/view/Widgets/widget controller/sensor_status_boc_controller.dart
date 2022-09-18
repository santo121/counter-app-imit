import 'package:flutter/cupertino.dart';

class SensorStatusBoxController with ChangeNotifier {
  bool _flag = true;

  bool get flag => _flag;

  void changeFlag(flag) {
    _flag = flag;
    notifyListeners();
  }
}
