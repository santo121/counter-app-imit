import 'dart:developer';
import 'package:counter_iot/colors.dart';
import 'package:counter_iot/const_file.dart';
import 'package:counter_iot/view/Widgets/buttons.dart';
import 'package:counter_iot/view/Widgets/widget%20controller/sensor_status_box.dart';
import 'package:counter_iot/view/Widgets/widget%20controller/sensor_status_box_controller.dart';
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
    sensorSwitching(true);
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
              sensorSwitching(true),
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
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: lnServerData.length,
              itemBuilder: (context, index) {
                // return Text(data[index].flag.toString());
                return Consumer<SensorStatusBoxController>(
                    builder: (context, myModel, child) {
                  // log("from consumer");
                  return padding(
                    child: SensorBoxStatus(
                      lnFlag: lnServerData[index].flag,
                      counterReadingSwitch: (val) {
                        log(val.toString());
                        counterSwitchDialog(index);
                      },
                      sensorStatus: lnServerData[index].switchFlag,
                      editVehicleNum: () {
                        myModel.changeFlag(myModel.flag ? false : true);
                        dialogBox(index);
                      },
                      vehicleNumber: lnServerData[index].vehicleNumber,
                    ),
                  );
                });
              }),
        ),
      );

  Widget jnSection() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: screenHeight(context) / 3.5,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: jnServerData.length,
              itemBuilder: (context, index) {
                // return Text(data[index].flag.toString());

                return Consumer<SensorStatusBoxController>(
                    builder: (context, myModel, child) {
                  log("from consumer");
                  return padding(
                    child: SensorBoxStatus(
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
              }),
        ),
      );

  Widget sensorSwitching(bool flag) {
    return SizedBox(
      width: screenWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Text("Working Mode :"),
              Text("Unloading"),
            ],
          ),
          TextButton(onPressed: () {}, child: const Text("Switch to loading"))
        ],
      ),
    );
  }

  Widget padding({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: child,
    );
  }

  dialogBox(index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              backgroundColor: Colors.black,
              title: Text(
                "Add vehicle number",
                style: TextStyle(
                  color: colorsList(colorsList: ColorsLists.white),
                ),
              ),
              content: Consumer<SensorStatusBoxController>(
                  builder: (context, myModel, child) {
                return Container(
                  decoration: BoxDecoration(
                      color: colorsList(colorsList: ColorsLists.white),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    onChanged: (val) {
                      lnServerData[index].vehicleNumber = val;
                      myModel.changeVehicleNumber(val);
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
                );
              }),
              actions: [
                buttonSelect(
                    context: context,
                    onTap: () {},
                    buttonType: ButtonType.acceptButton),
                buttonSelect(
                    context: context,
                    onTap: () {},
                    buttonType: ButtonType.denyButton),
              ],
            ),
          );
        });
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
