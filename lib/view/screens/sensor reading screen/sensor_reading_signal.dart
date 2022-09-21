import 'package:counter_iot/colors.dart';
import 'package:counter_iot/const_file.dart';
import 'package:counter_iot/view/Widgets/app_bar.dart';
import 'package:counter_iot/view/Widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SensorReadingSignal extends StatefulWidget {
  const SensorReadingSignal({Key? key}) : super(key: key);

  @override
  State<SensorReadingSignal> createState() => _SensorReadingSignalState();
}

class _SensorReadingSignalState extends State<SensorReadingSignal> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
    color:colorsList(colorsList: ColorsLists.black), //change your color here
  ),
          actions: [
            TextButton(
                onPressed: () {},
                child: Text(
                  "ADD SENSOR",
                  style: TextStyle(
                      color:
                          colorsList(colorsList: ColorsLists.textButtonColor)),
                ))
          ],
          backgroundColor: colorsList(
            colorsList: ColorsLists.primaryAppBarColor,
          ),
          elevation: 0,
          // title: Text('Sensor readings',
          //     style:
          //         TextStyle(color: colorsList(colorsList: ColorsLists.black))),
          bottom: TabBar(
            indicatorColor: colorsList(colorsList: ColorsLists.black),
            labelColor: colorsList(colorsList: ColorsLists.black),
            tabs: [
              SizedBox(
                child: Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "LN Sensors",
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(Icons.sensors)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "JN Sensors",
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(Icons.sensors)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.only( left: 20, right: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    sensorReadingWidget(true, true),
                    sensorReadingWidget(true, false),
                    sensorReadingWidget(true, true),
                    sensorReadingWidget(true, true),
                  ],
                ),
              ),
            )),
            Positioned(
              bottom: 10,
              right: 10,
              child: buttonSelect(buttonType: ButtonType.redirectionButton, onTap: (){}, context: context))
          ],
        ),
      ),
    );
  }

  Widget sensorReadingWidget(bool flag, sensorFlag) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 4,
      child: Column(
        children: [
          space10,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  sensorIndicators(sensorFlag),
                  wSpace20,
                  flag
                      ?  Text("LN Sensor one",style: textStyle(false,para: false),)
                      : Text("JN Sensor one",style: textStyle(false,para: false)),
                ],
              ),
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.all(5),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Verify",
                          style: TextStyle(
                              color: colorsList(
                                  colorsList: ColorsLists.textButtonColor)),
                        ),
                      )),
                  wSpace20,
                  IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
                ],
              )
            ],
          ),
          space10,
          Divider(
            height: .1,
            color: colorsList(colorsList: ColorsLists.gray),
          )
        ],
      ),
    );
  }

  Widget sensorIndicators(bool flag) {
    return SizedBox(
      width: 11,
      child: CircleAvatar(
        backgroundColor: colorsList(
            colorsList: flag ? ColorsLists.success : ColorsLists.failure),
      ),
    );
  }
}
