import 'dart:io';

import 'package:flutter/cupertino.dart';

String internetAddress = "0.0.0.0";

int portNumber = 4566;  
late ServerSocket server;
SizedBox space30 = const SizedBox(
  height: 20,
);
SizedBox space20 = const SizedBox(
  height: 20,
);
SizedBox space10 = const SizedBox(
  height: 10,
);
Radius radiusTen =  const Radius.circular(10);