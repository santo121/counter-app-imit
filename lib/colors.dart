import 'package:flutter/material.dart';

Color activeButtonColor = const Color(0xff0500FF);
enum sensorButtonColor { gray, blue, lightBlue,black,white,primary}

Color buttonC({required buttonColor}) {
  switch (buttonColor) {
    case sensorButtonColor.blue:
      {
        return const Color(0xff0500FF);
      }

    case sensorButtonColor.gray:
      {
        return const Color(0xffD9D9D9);
      }

    case sensorButtonColor.lightBlue:
      {
        return const Color(0xff7572FF); 
      }
    case sensorButtonColor.black:
      {
        return const Color(0xff000000); 
      }
    case sensorButtonColor.white:
      {
        return const Color(0xffFFFFFF);
      }
    case sensorButtonColor.primary:
      {
        return const Color(0xffEDEDED);
      }

    default:
      {
        return const Color(0xffFFFFFF);
      }
  }
}
