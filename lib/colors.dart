import 'package:flutter/material.dart';

Color activeButtonColor = const Color(0xff0500FF);
enum ColorsLists { gray, blue, lightBlue,black,white,primaryAppBarColor,backgroundColor,success,failure,textButtonColor}

Color colorsList({required colorsList}) {
  switch (colorsList) {
    case ColorsLists.blue:
      {
        return const Color(0xff0500FF);
      }

    case ColorsLists.gray:
      {
        return const Color(0xffD9D9D9);
      }

    case ColorsLists.lightBlue:
      {
        return const Color(0xff7572FF); 
      }
    case ColorsLists.black:
      {
        return const Color(0xff000000); 
      }
    case ColorsLists.white:
      {
        return const Color(0xffFFFFFF);
      }
    case ColorsLists.primaryAppBarColor:
      {
        return const Color(0xffEDEDED);
      }
    case ColorsLists.backgroundColor:
      {
        return const Color(0xffF2F2F2);
      }
    case ColorsLists.success:
      {
        return const Color(0xff80E400);
      }
    case ColorsLists.failure:
      {
        return const Color(0xffE30707);
      }
    case ColorsLists.textButtonColor:
      {
        return const Color(0xff0400DF);
      }

    default:
      {
        return const Color(0xffFFFFFF);
      }
  }
}
