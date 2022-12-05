import 'package:counter_iot/colors.dart';
import 'package:flutter/material.dart';

AppBar customAppBar({
  required String titles,
  required List<Widget> actions,
 
}) {
  return AppBar(
      title: Text(
        titles,
        style: TextStyle(color: colorsList(colorsList: ColorsLists.black)),
      ),
      elevation: 0,
      actions: actions,
      backgroundColor: colorsList(
        colorsList: ColorsLists.primaryAppBarColor,
      ),
      
      );
}
