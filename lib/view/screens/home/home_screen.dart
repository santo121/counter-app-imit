import 'dart:developer';
import 'dart:ui';

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
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
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

  List<SensorStatusBoxController> lnServerData = [
    SensorStatusBoxController(
        flag: true, switchFlag: true, vehicleNumber: "KL 45 0404"),
    SensorStatusBoxController(
        flag: true, switchFlag: false, vehicleNumber: "KL 45 0404"),
    SensorStatusBoxController(
        flag: true, switchFlag: true, vehicleNumber: "KL 45 0404"),
    SensorStatusBoxController(
        flag: true, switchFlag: true, vehicleNumber: "KL 45 0404"),
  ];
  List<SensorStatusBoxController> jnServerData = [
    SensorStatusBoxController(flag: false, switchFlag: true),
    SensorStatusBoxController(flag: false, switchFlag: false),
    SensorStatusBoxController(flag: false, switchFlag: true),
  ];
  @override
  Widget build(BuildContext context) {
    log("from build");
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          // padding: const EdgeInsets.only(left: 20, right: 20),
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              sensorSwitching(true),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: lnServerData.length,
                      itemBuilder: (context, index) {
                        // return Text(data[index].flag.toString());

                        return Consumer<SensorStatusBoxController>(
                            builder: (context, myModel, child) {
                          log("from consumer");

                          return padding(
                            child: SensorBoxStatus(
                              lnFlag: lnServerData[index].flag,
                              counterReadingSwitch: (val) {
                                // log(val.toString());
                                myModel.changeSwitchFlag(val);
                                lnServerData[index].switchFlag = val;
                              },
                              sensorStatus: lnServerData[index].switchFlag,
                              editVehicleNum: () {
                                myModel.changeFlag(myModel.flag ? false : true);
                                dialogBox();
                              },
                              vehicleNumber: lnServerData[index].vehicleNumber,
                            ),
                          );
                        });
                      }),
                ),
              ),
              space10,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
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
              ),

              // SensorBoxStatus(lnFlag: true),
              // SensorBoxStatus(lnFlag: true),
              // SensorBoxStatus(lnFlag: true),
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

  Widget sensorSwitching(bool flag) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
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

  void dialogBox() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            backgroundColor: Colors.black,
            title: Text(
              "Alert Dialog",
              style: TextStyle(
                color: colorsList(colorsList: ColorsLists.white),
              ),
            ),
            content: Container(
              decoration: BoxDecoration(
                  color: colorsList(colorsList: ColorsLists.white),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
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
                  onTap: () {},
                  buttonType: ButtonType.acceptButton),
              buttonSelect(
                  context: context,
                  onTap: () {},
                  buttonType: ButtonType.denyButton),
            ],
          );
        });
  }
}
