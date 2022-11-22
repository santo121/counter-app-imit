import 'dart:developer';

import 'package:counter_iot/colors.dart';
import 'package:counter_iot/const_file.dart';
import 'package:counter_iot/view/Widgets/buttons.dart';
import 'package:counter_iot/view/screens/home/home_screen.dart';
import 'package:counter_iot/view/screens/sensor%20reading%20screen/sensor_readed_result_controller.dart';
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
            // todo : <<<<<<<<<<<<<<<<<<<<<<<<  LN sensor section section >>>>>>>>>>>>>>>>>>>>>>>>

            Stack(
              children: [
                SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Consumer2<ServerController,SensorReadResultController>(
                        builder: (context, myModelServer,myModelStore, child) {
                      return ValueListenableBuilder(
                          valueListenable: listNot,
                          builder: (context, String model, child) {
                            return ListView.builder(
                                itemCount: myModelStore.lnSensorList.length + 1,
                                itemBuilder: (cont, index) {
                                  log(index.toString()+"index number from lane sensor builder");

                                  if (index != myModelStore.lnSensorList.length) {
                                    return sensorReadingWidget(
                                        myModelStore.lnSensorList[index].sensorType ==
                                                SensorType.lnSensor
                                            ? true
                                            : false,
                                        myModelStore.lnSensorList[index].verified,
                                        index, deleteFunc: () {
                                      deleteButtonConfirmationButton(context,
                                          acceptOnPressed: () {
                                      
                                        //todo: change the name to removeFromLnSensorList
                                        myModelStore.lnSensorList.removeAt(index);
                                        myModelStore.changeAddButtonFlag(true);
                                        Navigator.pop(context);
                                      }, cancelOnPressed: () {
                                        Navigator.pop(context);
                                      });

                                      listNot.value = '';
                                     myModelServer.existingValLn.removeAt(index);
                                    },
                                    //* <<<<<<<<<<< This will invoke >>>>>>>>>>>
                                    
                                     verifyButton: () {
                                 
                                        verifyOverDialogLN(
                                          context,
                                          index,
                                        );
                                     
                                    });
                                  }
                                 
                                    return myModelStore.addButtonFlag
                                              //* this button will help to add lane sensor
                                        ? TextButton(
                                            onPressed: () {
                                             
                                              //* here we just logged the tab count
                                              log(myModelServer.tabCount.toString());

                                              //* Specifying the sensor type by adding values to the controller
                                             
                                              myModelServer.changeSensorType(
                                                  sensorType:
                                                      SensorType.lnSensor);
                                                       log(index.toString()+"index number from lane sensor button");
                                              log(myModelServer.sensorType.toString()+"index number from lane sensor button");
                                              //*  <<<<<<< here we changing the verification status to false >>>>>>>
                                              myModelServer.changeVerification(
                                                  verified: false);
                                              //* <<<<<<<<<<<<<<< adding the value to sensor list >>>>>>>>>>>>>>>
                                            //  lnSensorList.add(
                                            //       ServerController.sn(
                                            //           sensorCount: index,
                                            //           sensorType:
                                            //               myModelServer.sensorType,
                                            //           verified:
                                            //               myModelServer.verified));

                                              //* <<<<<<<<<<<<<<< adding the value to the second controller >>>>>>>>>>>>>>>

                                                          myModelStore.addToLnSensor(
                                                            ServerController.sn(
                                                      sensorCount: index,
                                                      sensorType:
                                                          myModelServer.sensorType,
                                                      verified:
                                                          myModelServer.verified)
                                                          );

                                          
                                              myModelStore.changeAddButtonFlag(false);
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
            //! end : <<<<<<<<<<<<<<<<<<<<<<<<  LN sensor section section >>>>>>>>>>>>>>>>>>>>>>>>
            
            
            // todo : <<<<<<<<<<<<<<<<<<<<<<<<  Junction box sensor section >>>>>>>>>>>>>>>>>>>>>>>>

            Stack(
              children: [
                SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Consumer2<ServerController,SensorReadResultController>(
                        builder: (context, myModel,sensorStorage, child) {
                      return ValueListenableBuilder(
                          valueListenable: listNot,
                          builder: (context, String model, child) {
                            // print(model);
                            return ListView.builder(
                                itemCount: sensorStorage.jnSensorList.length + 1,
                                itemBuilder: (cont, index) {
                                  if (index != sensorStorage.jnSensorList.length) {
                                    return sensorReadingWidget(
                                        sensorStorage.jnSensorList[index].sensorType ==
                                                SensorType.lnSensor
                                            ? true
                                            : false,
                                        sensorStorage.jnSensorList[index].verified,
                                        index, deleteFunc: () {
                                      deleteButtonConfirmationButton(context,
                                          acceptOnPressed: () {
                                       
                                          sensorStorage.jnSensorList.removeAt(index);

                                          sensorStorage.changeAddButtonFlag( true);
                                        
                                        Navigator.pop(context);
                                      }, cancelOnPressed: () {
                                        Navigator.pop(context);
                                      });

                                      listNot.value = '';
                                      myModel.existingValJn.removeAt(index);
                                    }, verifyButton: () {
                                      final sensorStatus =
                                          sensorStorage.jnSensorList[index].sensorId;
                                      //! editing area
                                      log('from server controller ${myModel.sensorIdList}');
                                      log('from valueListen $model');

                                      verifyOverDialogJn(
                                        context,
                                        index,
                                      );
                                    });
                                  }
                                  
                                    return sensorStorage.addButtonFlag
                                        ? TextButton(
                                            onPressed: () {
                                              // todo: Specifying the sensor type by adding values to the controller
                                              myModel.changeSensorType(
                                                  sensorType:
                                                      SensorType.jnSensor);
                                              myModel.changeVerification(
                                                  verified: false);
                                              // todo: adding the value to sensor list
                                              // jnSensorList.add(
                                              //     ServerController.sn(
                                              //         sensorCount: 0,
                                              //         sensorType:
                                              //             myModel.sensorType,
                                              //         verified:
                                              //             myModel.verified));
                                              sensorStorage.addToJnSensor(
                                                 ServerController.sn(
                                                      sensorCount: index,
                                                      sensorType:
                                                          myModel.sensorType,
                                                      verified:
                                                          myModel.verified)
                                              );
                                              
                                               sensorStorage.changeAddButtonFlag(false);
                                              
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
          
            //! end: <<<<<<<<<<<<<<<<<<<<<<<<  Junction box sensor section >>>>>>>>>>>>>>>>>>>>>>>>
          
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
// todo : <<<<<<<<<<<<<<<<<<<<<<<<  This is a widget it help the users to see the sensor list >>>>>>>>>>>>>>>>>>>>>>>>

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
                      ? Text(Provider.of<SensorReadResultController>(context).lnSensorList[index].sensorId ?? "Lane Sensor",
                          style: textStyle(false, para: false))
                      : Text(Provider.of<SensorReadResultController>(context).jnSensorList[index].sensorId ?? "Junction Box",
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

// ! end: <<<<<<<<<<<<<<<<<<<<<<<<  This is a widget it help the users to see the sensor list >>>>>>>>>>>>>>>>>>>>>>>>


// todo : <<<<<<<<<<<<<<<<<<<<<<<<  This method will help the user for identifying the sensor is accepted or not >>>>>>>>>>>>>>>>>>>>>>>>

  Widget sensorIndicators(bool flag) {
    return SizedBox(
      width: 11,
      child: CircleAvatar(
        backgroundColor: colorsList(
            colorsList: flag ? ColorsLists.success : ColorsLists.failure),
      ),
    );
  }

// ! end: <<<<<<<<<<<<<<<<<<<<<<<<  This method will help the user for identifying the accepted or not >>>>>>>>>>>>>>>>>>>>>>>>


// todo : <<<<<<<<<<<<<<<<<<<<<<<<  This method will help the user for verifying the signal form the Lane sensor >>>>>>>>>>>>>>>>>>>>>>>>

  verifyOverDialogJn(context, int index) {
    log(index.toString());
    
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer2<ServerController,SensorReadResultController>(builder: (context, myModel,sensorStorage, _) {
            return ValueListenableBuilder(
                valueListenable: listNot,
                builder: (context, String model, _) {
                  log(myModel.existingValJn.toString());
                  log(model.isNotEmpty.toString());
                  log(myModel.existingValJn.toString());
                  if (model.isNotEmpty &&
                      myModel.existingValJn.contains(model) == false &&
                      myModel.existingValLn.contains(model) == false &&
                      sensorStorage.jnSensorList[index].sensorId == null) {
                    return AlertDialog(
                        backgroundColor: Colors.black,
                        content: const Text(
                          'Reading result',
                          style: TextStyle(color: Colors.white),
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                sensorStorage.jnSensorList[index].sensorId = model;
                                myModel.changeSensorId(val: model.toString());
                                log(index.toString());
                                myModel.changeExistingValJn(index, model);
                                
                                  sensorStorage.changeAddButtonFlag(true);
                                
                                myModel.changeVerification(verified: true);
                                sensorStorage.jnSensorList[index].verified = true;
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

// ! end: <<<<<<<<<<<<<<<<<<<<<<<<  This method will help the user for verifying the signal form the Lane sensor >>>>>>>>>>>>>>>>>>>>>>>>


// todo : <<<<<<<<<<<<<<<<<<<<<<<<  this function will help to pop up a window for delete conformation  >>>>>>>>>>>>>>>>>>>>>>>>
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
// ! end: <<<<<<<<<<<<<<<<<<<<<<<<  This function will help to pop up a window for delete conformation  >>>>>>>>>>>>>>>>>>>>>>>>



// todo : <<<<<<<<<<<<<<<<<<<<<<<<  This method will help the user for verifying the signal form the junction box sensor >>>>>>>>>>>>>>>>>>>>>>>>

  verifyOverDialogLN(context, index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer2<ServerController,SensorReadResultController>(builder: (context, myModel,sensorStorage, _) {
            return ValueListenableBuilder(
                valueListenable: listNot,
                builder: (context, String model, _) {
                  log(myModel.existingValLn.toString());
                  log(model.isNotEmpty.toString());
                  log(myModel.existingValLn.toString());
                  if (model.isNotEmpty &&
                      myModel.existingValLn.contains(model) == false &&
                      myModel.existingValJn.contains(model) == false &&
                      sensorStorage.lnSensorList[index].sensorId == null) {
                    return AlertDialog(
                        backgroundColor: Colors.black,
                        content: const Text(
                          'Reading result',
                          style: TextStyle(color: Colors.white),
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                sensorStorage.lnSensorList[index].sensorId = model;
                                myModel.changeExistingValLn(index, model);
                                myModel.changeSensorId(val: model.toString());
                                
                                  sensorStorage.changeAddButtonFlag(true);
                               
                                sensorStorage.lnSensorList[index].verified = true;
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

// ! End: <<<<<<<<<<<<<<<<<<<<<<<<  This method will help the user for verifying the signal form the junction box sensor >>>>>>>>>>>>>>>>>>>>>>>>

}
