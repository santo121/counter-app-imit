import 'dart:developer';

import 'package:counter_iot/colors.dart';
import 'package:counter_iot/const_file.dart';
import 'package:counter_iot/view/Widgets/buttons.dart';
import 'package:counter_iot/view/screens/home/home_screen.dart';
import 'package:counter_iot/view/screens/sensor%20reading%20screen/senor_reading_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SensorReadingSignal extends StatefulWidget {
  const SensorReadingSignal({Key? key}) : super(key: key);

  @override
  State<SensorReadingSignal> createState() => _SensorReadingSignalState();
}

class _SensorReadingSignalState extends State<SensorReadingSignal> {
  final List<SensorReadingController> lnSensorList = [
    SensorReadingController.sn(
        sensorType: SensorType.lnSensor, verified: false),
    SensorReadingController.sn(
        sensorType: SensorType.lnSensor, verified: false),
    SensorReadingController.sn(
        sensorType: SensorType.lnSensor, verified: false),
  ];
  final List<SensorReadingController> jnSensorList = [
    SensorReadingController.sn(
        sensorType: SensorType.jnSensor, verified: false),
    SensorReadingController.sn(
        sensorType: SensorType.jnSensor, verified: false),
    SensorReadingController.sn(
        sensorType: SensorType.jnSensor, verified: false),
  ];

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: colorsList(
                colorsList: ColorsLists.black), //change your color here
          ),
          actions: [
            //! Add sensor - button
            Consumer<SensorReadingController>(
                builder: (context, myModel, child) {
              return TextButton(
                  onPressed: () {
                    log(myModel.tabCount.toString());
                    if (myModel.tabCount == 0) {
                      // todo: Specifying the sensor type by adding values to the controller
                      myModel.changeSensorType(sensorType: SensorType.lnSensor);
                      myModel.changeVerification(verified: false);
                      // todo: adding the value to sensor list
                      lnSensorList.add(SensorReadingController.sn(
                          sensorType: myModel.sensorType,
                          verified: myModel.verified));
                    } else {
                      // todo: Specifying the sensor type by adding values to the controller
                      myModel.changeSensorType(sensorType: SensorType.jnSensor);
                      myModel.changeVerification(verified: false);
                      // todo: adding the value to sensor list
                      jnSensorList.add(SensorReadingController.sn(
                          sensorType: myModel.sensorType,
                          verified: myModel.verified));
                    }
                  },
                  child: Text(
                    "ADD SENSOR",
                    style: TextStyle(
                        color: colorsList(
                            colorsList: ColorsLists.textButtonColor)),
                  ));
            })
          ],
          backgroundColor: colorsList(
            colorsList: ColorsLists.primaryAppBarColor,
          ),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Consumer<SensorReadingController>(
                builder: (context, myModel, child) {
              return TabBar(
                indicatorColor: colorsList(colorsList: ColorsLists.black),
                labelColor: colorsList(colorsList: ColorsLists.black),
                onTap: (val) {
                  myModel.changedTabCount(val);
                },
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
                            Icon(Icons.sensors),
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
                indicatorSize: TabBarIndicatorSize.tab,
              );
            }),
          ),
        ),
        body: TabBarView(
          children: [
            // ! LN sensor section
            Stack(
              children: [
                SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Consumer<SensorReadingController>(
                        builder: (context, myModel, child) {
                      return ListView.builder(
                          itemCount: lnSensorList.length,
                          itemBuilder: (cont, index) {
                            return sensorReadingWidget(
                                lnSensorList[index].sensorType ==
                                        SensorType.lnSensor
                                    ? true
                                    : false,
                                lnSensorList[index].verified,
                                index, deleteFunc:() {
                              setState(() {
                                lnSensorList.removeAt(index);
                              });
                            });
                          });
                    }),
                  ),
                )),
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: buttonSelect(
                        buttonType: ButtonType.redirectionButton,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                          );
                        },
                        context: context))
              ],
            ),
            // ! jn sensor section
            Stack(
              children: [
                SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Consumer<SensorReadingController>(
                        builder: (context, myModel, child) {
                      return ListView.builder(
                          itemCount: jnSensorList.length,
                          itemBuilder: (cont, index) {
                            return sensorReadingWidget(
                                jnSensorList[index].sensorType ==
                                        SensorType.lnSensor
                                    ? true
                                    : false,
                                jnSensorList[index].verified,
                                index,deleteFunc:() {
                              setState(() {
                                jnSensorList.removeAt(index);
                              });
                            });
                          });
                    }),
                  ),
                )),
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: buttonSelect(
                        buttonType: ButtonType.redirectionButton,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                          );
                        },
                        context: context))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget sensorReadingWidget(bool flag, sensorFlag, int index,{required deleteFunc,} ) {
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
                      ? Text("LN Sensor one",
                          style: textStyle(false, para: false))
                      : Text("JN Sensor one",
                          style: textStyle(false, para: false)),
                ],
              ),
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.all(5),
                      child: sensorFlag
                          ? const SizedBox()
                          : TextButton(
                              onPressed: () {},
                              child: Text(
                                "Verify",
                                style: TextStyle(
                                    color: colorsList(
                                        colorsList:
                                            ColorsLists.textButtonColor)),
                              ),
                            )),
                  wSpace20,
                  IconButton(
                      onPressed: deleteFunc, icon: const Icon(Icons.delete)),
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
