
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class HomeScreenController with ChangeNotifier {
  bool signalData = false;
String val = '';
  void changeSignalData(bool val) {
    signalData = val;
    notifyListeners();
  }
  void addString(String vals) {
    val = vals;
    notifyListeners();
  }

  void offSignalData() {
    // Timer.periodic(Duration(seconds: 3), (_)=>{log('dasdadas'),
    signalData = false;
      log('insidefosdfpop timer');
      print('hdkhafkhfjhgzsjhkgjkhf');

    notifyListeners();
    }
    
    
    
    



}
