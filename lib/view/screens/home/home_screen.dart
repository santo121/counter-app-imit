import 'dart:async';
import 'dart:developer';
import 'package:counter_iot/colors.dart';
import 'package:counter_iot/const_file.dart';
import 'package:counter_iot/controller/server/server_controller.dart';
import 'package:counter_iot/view/Widgets/buttons.dart';
import 'package:counter_iot/view/Widgets/widget%20controller/sensor_status_box.dart';
import 'package:counter_iot/view/Widgets/widget%20controller/sensor_status_box_controller.dart';
import 'package:counter_iot/view/screens/home/home_screen_controller.dart';
import 'package:counter_iot/view/screens/sensor%20reading%20screen/sensor_readed_result_controller.dart';
import 'package:counter_iot/view/screens/sensor%20reading%20screen/sensor_reading_signal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    space20;
    sensorSwitching(true, onPress: () {});
    super.dispose();
  }

//! ln section model data
  List<SensorStatusBoxController> lnServerData = [
    SensorStatusBoxController.ln(
        flag: true, switchFlag: false, vehicleNumber: "KL 45 0404"),
    SensorStatusBoxController.ln(
        flag: true, switchFlag: false, vehicleNumber: "KL 45 0404"),
    SensorStatusBoxController.ln(
        flag: true, switchFlag: false, vehicleNumber: "KL 45 0404"),
    SensorStatusBoxController.ln(
        flag: true, switchFlag: false, vehicleNumber: "KL 45 0404"),
  ];
  //! jn section model data
  List<SensorStatusBoxController> jnServerData = [
    SensorStatusBoxController.jn(flag: false, switchFlag: true),
    SensorStatusBoxController.jn(flag: false, switchFlag: false),
    SensorStatusBoxController.jn(flag: false, switchFlag: true),
  ];

  @override
  Widget build(BuildContext context) {
    // log("from build");
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: screenWidth(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //todo: sensor switching area
              sensorSwitching(true, onPress: () {}),
              //todo: ln section
              lnSection(),
              space10,
              //todo: Jn section
              jnSection(),
              space20

              // todo: Add vehicle number or fetch from database
              // todo: switch control to start or end the process of counting
              // todo: need get the count of the reading form the client side
              // todo: need to get the last pick time and date from data base or form API ()
              // todo: vehicle number adding is by the help of dialog
            ],
          ),
        ),
      )),
    );
  }

  Widget lnSection() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: screenHeight(context) / 2,
          child: Consumer2<SensorStatusBoxController,SensorReadResultController>(
            builder: (context, myModel,sensorStorage ,child) {
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: sensorStorage.lnSensorList.length,
                  itemBuilder: (context, index) {
                    // return Text(data[index].flag.toString());
                    
                      // log("from consumer");
                      return padding(
                        child: SensorBoxStatus(
                          activeSensorBox: sensorStorage.lnSensorList[index].verified,
                          sensorName: sensorStorage.lnSensorList[index].sensorId.toString(),
                          lnFlag: lnServerData[index].flag,
                          counterReadingSwitch: (val) {
                            log(val.toString());
                            counterSwitchDialog(index);
                          },
                          sensorStatus: lnServerData[index].switchFlag,
                          editVehicleNum: () {
                            myModel.changeFlag(myModel.flag ? false : true);
                            sensorStorage.lnSensorList[index].verified?
                            
                            vehicleNumberDialogBox(index):errorMessage();
                          },
                          vehicleNumber:sensorStorage.lnSensorList[index].vehicleNumber?? "Add vehicle",
                        ),
                      );
                    
                  });
            }
          ),
        ),
      );

  Widget jnSection() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: screenHeight(context) / 3.5,
          child: Consumer2<SensorStatusBoxController,SensorReadResultController>(
            builder: (context,myModel,sensorStorage,_) {
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: sensorStorage.jnSensorList.length,
                  itemBuilder: (context, index) {
                    // return Text(data[index].flag.toString());

                    
                      log("from consumer");
                      return padding(
                        child: SensorBoxStatus(
                          activeSensorBox: sensorStorage.jnSensorList[index].verified,
                          sensorName: sensorStorage.jnSensorList[index].sensorId.toString(),
                          lnFlag: jnServerData[index].flag,
                          counterReadingSwitch: (val) {
                            // log(val.toString());

                            myModel.changeSwitchFlag(val);
                            jnServerData[index].switchFlag = val;
                          },
                          sensorStatus: lnServerData[index].switchFlag,
                          editVehicleNum: () {},
                          vehicleNumber: "",
                        ),
                      );
                   
                  });
            }
          ),
        ),
      );

Future<void>offTheSignal()async{
await Future.delayed(const Duration(seconds: 3));
 print('add some delay and false it');
               Provider.of<HomeScreenController>(context,listen: false).offSignalData();
               Provider.of<HomeScreenController>(context,listen: false).addString('');
}

  Widget sensorSwitching(bool flag, {required onPress}) {
    return Consumer<HomeScreenController>(
        builder: (context, homeController, _) {
      return ValueListenableBuilder(
          valueListenable: listNot,
          builder: (context, myModel, _) {
            homeController.addString(listNot.value);
            log("fata 1");

            homeController
                .changeSignalData(homeController.val == '' ? false : true);
            if (homeController.signalData == true) {
              offTheSignal();

            } else {
              homeController
                  .changeSignalData(homeController.val == '' ? false : true);


            }
            log(homeController.val);
            log(homeController.signalData.toString());

    
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: screenWidth(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      sensorIndicators(homeController.signalData),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("Working Mode :"),
                      const Text("Unloading"),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: onPress,
                          child: const Text("Switch to loading")),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SensorReadingSignal()),
                            );
                          },
                          icon: const Icon(Icons.menu)),
                    ],
                  )
                ],
              ),
            );
          });
    });
  }

  Widget padding({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: child,
    );
  }


  errorMessage(){
    showDialog(context: context, builder:(BuildContext context){
      return  AlertDialog(
                      backgroundColor: Colors.black,
                      title: Row(
                        children: const [
                          Text(
                            'Sensor Error',
                            style: TextStyle(color: Color(0xFFFF0000)),
                          ),
                          
                        
                        ],
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            'You are not allowed to add\nvehicle number here.\nYou need to verify the sensor first',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
    });
  }

  vehicleNumberDialogBox(index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Consumer2<SensorStatusBoxController,SensorReadResultController >(
              builder: (context, myModel,sensorStorage ,child) {
                return AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  backgroundColor: Colors.black,
                  title: Text(
                    "Add vehicle number",
                    style: TextStyle(
                      color: colorsList(colorsList: ColorsLists.white),
                    ),
                  ),
                  content:
                    Container(
                      decoration: BoxDecoration(
                          color: colorsList(colorsList: ColorsLists.white),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                        onChanged: (val) {
                          setState(() {
                            lnServerData[index].vehicleNumber = val;
                          myModel.changeVehicleNumber(val);
                          });
                          
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(13),
                        ],
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                            hintText: "Vehicle number",
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                                color: colorsList(colorsList: ColorsLists.gray))),
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: colorsList(colorsList: ColorsLists.black)),
                      ),
                    ),
                  
                  actions: [
                    buttonSelect(
                        context: context,
                        onTap: () {
                          sensorStorage.lnSensorList[index].verified?
                         sensorStorage.lnSensorList[index].vehicleNumber=myModel.vehicleNumber:'';
                          Navigator.pop(context);
                        },
                        buttonType: ButtonType.acceptButton),
                    buttonSelect(
                        context: context,
                        onTap: () {
                          Navigator.pop(context);

                        },
                        buttonType: ButtonType.denyButton),
                  ],
                );
              }
            ),
          );
        });
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

  counterSwitchDialog(index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<SensorStatusBoxController>(
              builder: (context, myModel, child) {
            return SingleChildScrollView(
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                backgroundColor: Colors.black,
                content: lnServerData[index].switchFlag
                    ? Text(
                        "Close the counter by pressing allow",
                        style: TextStyle(
                          color: colorsList(colorsList: ColorsLists.white),
                        ),
                      )
                    : Text(
                        "Start the counter by pressing allow",
                        style: TextStyle(
                          color: colorsList(colorsList: ColorsLists.white),
                        ),
                      ),
                actions: [
                  buttonSelect(
                      context: context,
                      onTap: () {
                        if (lnServerData[index].switchFlag) {
                          // log(lnServerData[index].switchFlag.toString());
                          myModel.changeSwitchFlag(false);
                          lnServerData[index].switchFlag = false;
                        } else if (lnServerData[index].switchFlag == false) {
                          myModel.changeSwitchFlag(true);
                          lnServerData[index].switchFlag = true;
                        }

                        // todo: add codes here
                        Navigator.pop(context);
                      },
                      buttonType: ButtonType.acceptButton),
                  buttonSelect(
                      context: context,
                      onTap: () {
                        // log(myModel.switchFlag.toString());

                        // todo: add codes here
                        Navigator.pop(context);
                      },
                      buttonType: ButtonType.denyButton),
                ],
              ),
            );
          });
        });
  }
}
