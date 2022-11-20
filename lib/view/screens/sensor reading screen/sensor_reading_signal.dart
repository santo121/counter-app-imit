import 'dart:developer';

import 'package:counter_iot/colors.dart';
import 'package:counter_iot/const_file.dart';
import 'package:counter_iot/view/Widgets/buttons.dart';
import 'package:counter_iot/view/screens/home/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../controller/server/server_controller.dart';

class SensorReadingSignal extends StatefulWidget {
  const SensorReadingSignal({Key? key}) : super(key: key);

  @override
  State<SensorReadingSignal> createState() => _SensorReadingSignalState();
}

class _SensorReadingSignalState extends State<SensorReadingSignal> {
  final List<ServerController> lnSensorList = [];
  final List<ServerController> jnSensorList = [];
  bool addButtonFlag = true;
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
          title: const Text(
            "Manage Sensors",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(
            color: colorsList(
                colorsList: ColorsLists.black), //change your color here
          ),
          // actions: [
          //   //! Add sensor - button
          //   Consumer<SensorReadingController>(
          //       builder: (context, myModel, child) {
          //     return TextButton(
          //         onPressed: () {
          //           log(myModel.tabCount.toString());
          //           if (myModel.tabCount == 0) {
          //             // todo: Specifying the sensor type by adding values to the controller
          //             myModel.changeSensorType(sensorType: SensorType.lnSensor);
          //             myModel.changeVerification(verified: false);
          //             // todo: adding the value to sensor list
          //             lnSensorList.add(SensorReadingController.sn(
          //                 sensorCount: 0,
          //                 sensorType: myModel.sensorType,
          //                 verified: myModel.verified));
          //           } else {
          //             // todo: Specifying the sensor type by adding values to the controller
          //             myModel.changeSensorType(sensorType: SensorType.jnSensor);
          //             myModel.changeVerification(verified: false);
          //             // todo: adding the value to sensor list
          //             jnSensorList.add(SensorReadingController.sn(
          //                 sensorCount: 0,
          //                 sensorType: myModel.sensorType,
          //                 verified: myModel.verified));
          //           }
          //         },
          //         child: Text(
          //           "ADD SENSOR",
          //           style: TextStyle(
          //               color: colorsList(
          //                   colorsList: ColorsLists.textButtonColor)),
          //         ));
          //   })
          // ],
          backgroundColor: colorsList(
            colorsList: ColorsLists.primaryAppBarColor,
          ),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child:
                Consumer<ServerController>(builder: (context, myModel, child) {
              return TabBar(
                physics: const NeverScrollableScrollPhysics(),
                indicatorColor: colorsList(colorsList: ColorsLists.black),
                labelColor: colorsList(colorsList: ColorsLists.black),
                onTap: (val) {
                  myModel.changedTabCount(val);
                },
                dragStartBehavior: DragStartBehavior.start,
                // isScrollable: false,

                tabs: [laneSensorTabHead(), junctionBoxTabHead()],
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
                    child: Consumer<ServerController>(
                        builder: (context, myModel, child) {
                      return ValueListenableBuilder(
                          valueListenable: listNot,
                          builder: (context, String model, child) {
                            return ListView.builder(
                                itemCount: lnSensorList.length + 1,
                                itemBuilder: (cont, index) {
                                  log('data  ${lnSensorList.length.toString()}');
                                  log('data index ${index.toString()}');

                                  if (index != lnSensorList.length) {
                                    log(lnSensorList.length.toString());
                                    return sensorReadingWidget(
                                        lnSensorList[index].sensorType ==
                                                SensorType.lnSensor
                                            ? true
                                            : false,
                                        lnSensorList[index].verified,
                                        index, deleteFunc: () {
                                      deleteButtonConfirmationButton(context,
                                          acceptOnPressed: () {
                                        setState(() {
                                          lnSensorList.removeAt(index);

                                          addButtonFlag = true;
                                        });
                                        Navigator.pop(context);
                                      }, cancelOnPressed: () {
                                        Navigator.pop(context);
                                      });

                                      listNot.value = '';
                                      myModel.existingValLn.removeAt(index);
                                    }, verifyButton: () {
                                      setState(() {
                                        verifyOverDialogLN(
                                          context,
                                          index,
                                        );
                                      });
                                    });
                                  }
                                  return Consumer<ServerController>(
                                      builder: (context, myModel, child) {
                                    return addButtonFlag
                                        ? TextButton(
                                            onPressed: () {
                                              log(myModel.tabCount.toString());

                                              // todo: Specifying the sensor type by adding values to the controller
                                              myModel.changeSensorType(
                                                  sensorType:
                                                      SensorType.lnSensor);
                                              myModel.changeVerification(
                                                  verified: false);
                                              // todo: adding the value to sensor list
                                              lnSensorList.add(
                                                  ServerController.sn(
                                                      sensorCount: index,
                                                      sensorType:
                                                          myModel.sensorType,
                                                      verified:
                                                          myModel.verified));
                                              setState(() {
                                                addButtonFlag = false;
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.add,
                                                  color: colorsList(
                                                      colorsList: ColorsLists
                                                          .textButtonColor),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "'ADD VEHICLE LANE SENSOR",
                                                  style: TextStyle(
                                                      color: colorsList(
                                                          colorsList: ColorsLists
                                                              .textButtonColor)),
                                                ),
                                              ],
                                            ))
                                        : const SizedBox();
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
                    child: Consumer<ServerController>(
                        builder: (context, myModel, child) {
                      return ValueListenableBuilder(
                          valueListenable: listNot,
                          builder: (context, String model, child) {
                            // print(model);
                            return ListView.builder(
                                itemCount: jnSensorList.length + 1,
                                itemBuilder: (cont, index) {
                                  if (index != jnSensorList.length) {
                                    return sensorReadingWidget(
                                        jnSensorList[index].sensorType ==
                                                SensorType.lnSensor
                                            ? true
                                            : false,
                                        jnSensorList[index].verified,
                                        index, deleteFunc: () {
                                      setState(() {
                                        jnSensorList.removeAt(index);
                                        addButtonFlag = true;
                                      });
                                      myModel.existingValJn.removeAt(index);
                                      listNot.value = '';
                                    }, verifyButton: () {
                                      // final sensorId = Provider.of<ServerController>(context).value;
                                      final sensorStatus =
                                          jnSensorList[index].sensorId;
                                      //! editing area
                                      log('from server controller ${myModel.sensorIdList}');
                                      log('from valueListen $model');

                                      verifyOverDialog(
                                        context,
                                        index,
                                      );

//                                       if(model.isNotEmpty&&myModel.existingVal.contains(model)==false){
//                                       myModel.changeExistingVal(model);
// log(myModel.existingVal.toString());
//                                       }
                                    });
                                  }
                                  return Consumer<ServerController>(
                                      builder: (context, myModel, child) {
                                    return addButtonFlag
                                        ? TextButton(
                                            onPressed: () {
                                              // todo: Specifying the sensor type by adding values to the controller
                                              myModel.changeSensorType(
                                                  sensorType:
                                                      SensorType.jnSensor);
                                              myModel.changeVerification(
                                                  verified: false);
                                              // todo: adding the value to sensor list
                                              jnSensorList.add(
                                                  ServerController.sn(
                                                      sensorCount: 0,
                                                      sensorType:
                                                          myModel.sensorType,
                                                      verified:
                                                          myModel.verified));
                                              setState(() {
                                                addButtonFlag = false;
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.add,
                                                  color: colorsList(
                                                      colorsList: ColorsLists
                                                          .textButtonColor),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "ADD JUNCTION BOX SENSOR",
                                                  style: TextStyle(
                                                      color: colorsList(
                                                          colorsList: ColorsLists
                                                              .textButtonColor)),
                                                ),
                                              ],
                                            ))
                                        : const SizedBox();
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

  SizedBox junctionBoxTabHead() {
    return SizedBox(
      child: Tab(
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                "Junction Boxes",
                style: TextStyle(fontSize: 16),
              ),
              Icon(Icons.sensors)
            ],
          ),
        ),
      ),
    );
  }

  SizedBox laneSensorTabHead() {
    return SizedBox(
      child: Tab(
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                "Vehicle Lanes",
                style: TextStyle(fontSize: 16),
              ),
              Icon(Icons.sensors),
            ],
          ),
        ),
      ),
    );
  }

  Widget sensorReadingWidget(bool flag, sensorFlag, int index,
      {required deleteFunc, required verifyButton}) {
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
                      ? Text(lnSensorList[index].sensorId ?? "Lane Sensor",
                          style: textStyle(false, para: false))
                      : Text(jnSensorList[index].sensorId ?? "Junction Box",
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
                              onPressed: verifyButton,
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

  verifyOverDialog(context, int index) {
    log(index.toString());
    final sensorStatus = jnSensorList[index].sensorId;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<ServerController>(builder: (context, myModel, _) {
            return ValueListenableBuilder(
                valueListenable: listNot,
                builder: (context, String model, _) {
                  log(myModel.existingValJn.toString());
                  log(model.isNotEmpty.toString());
                  log(myModel.existingValJn.toString());
                  if (model.isNotEmpty &&
                      myModel.existingValJn.contains(model) == false &&
                      myModel.existingValLn.contains(model) == false &&
                      sensorStatus == null) {
                    return AlertDialog(
                        backgroundColor: Colors.black,
                        content: const Text(
                          'Reading result',
                          style: TextStyle(color: Colors.white),
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                jnSensorList[index].sensorId = model;
                                myModel.changeSensorId(val: model.toString());
                                log(index.toString());
                                myModel.changeExistingValJn(index, model);
                                setState(() {
                                  addButtonFlag = true;
                                });
                                myModel.changeVerification(verified: true);
                                jnSensorList[index].verified = true;
                                log("printing");
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Add result',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colorsList(
                                      colorsList: ColorsLists.lightBlue))),
                          ElevatedButton(
                            onPressed: () {
                              listNot.value = '';
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    colorsList(colorsList: ColorsLists.blue)),
                          )
                        ]);
                  } else {
                    return AlertDialog(
                      backgroundColor: Colors.black,
                      title: const Text(
                        'Waiting for Signal..',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            'Waiting for Signal..',
                            style: TextStyle(color: Colors.white),
                          ),
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  }
                });
          });
        });
  }

  deleteButtonConfirmationButton(
    context, {
    required void Function()? cancelOnPressed,
    required void Function()? acceptOnPressed,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Consumer<ServerController>(builder: (context, myModel, _) {
            return ValueListenableBuilder(
                valueListenable: listNot,
                builder: (context, String model, _) {
                  return AlertDialog(
                    backgroundColor: Colors.black,
                    title: Row(
                      children: const [],
                    ),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          'All previously stored activity\ndata for this sensor will be lost.\nContinue?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: cancelOnPressed,
                          child: const Text('Cancel')),
                      ElevatedButton(
                          onPressed: acceptOnPressed,
                          child: const Text('Continue')),
                    ],
                  );
                });
          });
        });
  }

  verifyOverDialogLN(context, index) {
    final sensorStatus = lnSensorList[index].sensorId;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<ServerController>(builder: (context, myModel, _) {
            return ValueListenableBuilder(
                valueListenable: listNot,
                builder: (context, String model, _) {
                  log(myModel.existingValLn.toString());
                  log(model.isNotEmpty.toString());
                  log(myModel.existingValLn.toString());
                  if (model.isNotEmpty &&
                      myModel.existingValLn.contains(model) == false &&
                      myModel.existingValJn.contains(model) == false &&
                      sensorStatus == null) {
                    return AlertDialog(
                        backgroundColor: Colors.black,
                        content: const Text(
                          'Reading result',
                          style: TextStyle(color: Colors.white),
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                lnSensorList[index].sensorId = model;
                                myModel.changeExistingValLn(index, model);
                                myModel.changeSensorId(val: model.toString());
                                setState(() {
                                  addButtonFlag = true;
                                });
                                lnSensorList[index].verified = true;
                                myModel.changeVerification(verified: true);
                                log("printing");
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Add the result',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colorsList(
                                      colorsList: ColorsLists.lightBlue))),
                          ElevatedButton(
                            onPressed: () {
                              listNot.value = '';
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    colorsList(colorsList: ColorsLists.blue)),
                          )
                        ]);
                  } else {
                    return AlertDialog(
                      backgroundColor: Colors.black,
                      title: Row(
                        children: const [
                          Text(
                            'Waiting for Signal..',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          CircularProgressIndicator(),
                        ],
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            'Switch on the sensor to be\nverified and swipe the AdminTag\non it',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  }
                });
          });
        });
  }
}
