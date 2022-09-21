import 'package:counter_iot/colors.dart';
import 'package:counter_iot/const_file.dart';
import 'package:counter_iot/view/Widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SensorCreationPage extends StatelessWidget {
  const SensorCreationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorsList(colorsList: ColorsLists.gray),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            SizedBox(child: Text("You don’t generated any sensors yet", style: textStyle(true))),
            space30,
            SizedBox(
              child: Text("Please add lane sensors by pressing the button given bellow",
                  style: textStyle(false)),
            ),
                space10,
            buttonSelect(
                context: context,
                onTap: () {},
                buttonType: ButtonType.lnAddSensor),
                space20,
            SizedBox(
              child: Text(
                  "Please add junction sensors by pressing the button given bellow",
                  style: textStyle(false)),
            ),
                space10,
            buttonSelect(
                context: context,
                onTap: () {},
                buttonType: ButtonType.jnAddSensor),
        ],
      ),
          )),
    );
  }

  
}
