import 'dart:developer';

import 'package:counter_iot/const_file.dart';
import 'package:counter_iot/view/Widgets/widget%20controller/sensor_status_box.dart';
import 'package:counter_iot/view/Widgets/widget%20controller/sensor_status_box_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
List<SensorStatusBoxController> data=[
  SensorStatusBoxController(flag: false,switchFlag: true),
  SensorStatusBoxController(flag: false,switchFlag: false),
  SensorStatusBoxController(flag: true,switchFlag: true),
  SensorStatusBoxController(flag: true,switchFlag: true),
];
  @override
  Widget build(BuildContext context) {
    log("from build");
    return Scaffold(
      body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              
              children: [
                sensorSwitching(true),

                Expanded(
                  
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                          // return Text(data[index].flag.toString());

                        return Consumer<SensorStatusBoxController>(
                            builder: (context, myModel, child) {
                              log("from consumer");

                          return lnSensorList([
                            SensorBoxStatus(
                              lnFlag: data[index].flag,
                              counterReadingSwitch: (val) {

                                // log(val.toString());
                                myModel.changeSwitchFlag(val);
                                data[index].switchFlag=val;
                              },
                              sensorStatus: data[index].switchFlag,
                              editVehicleNum: () {},
                              vehicleNumber: "",
                            )
                          ]);
                        });
                      }
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
                space20,
                lnSensorList([
                  
                ]),
              ],
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

  Widget lnSensorList(List<Widget> lnSensor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: lnSensor,
    );
  }
}
