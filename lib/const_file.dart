import 'dart:io';

import 'package:counter_iot/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

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
SizedBox wSpace20 = const SizedBox(
  width: 20,
);
Radius radiusTen =  const Radius.circular(10);

TextStyle textStyle(bool head,{ bool para = true}) {
    return GoogleFonts.poppins(
        fontSize:para? head ? 16 : 14:18,
        fontStyle: FontStyle.normal,
        fontWeight: head ? FontWeight.w600 : FontWeight.w300,
        color: colorsList(colorsList: ColorsLists.black));
  }

  double screenWidth(context) => MediaQuery.of(context).size.width;
  double screenHeight(context) => MediaQuery.of(context).size.height;