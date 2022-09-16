import 'dart:io';

import 'package:flutter/cupertino.dart';

String internetAddress = "0.0.0.0";
int portNumber = 4566;  
late ServerSocket server;
SizedBox space20 = const SizedBox(
  height: 20,
);