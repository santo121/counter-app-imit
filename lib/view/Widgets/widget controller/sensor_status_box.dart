import 'dart:developer';

import 'package:counter_iot/colors.dart';
import 'package:counter_iot/const_file.dart';
import 'package:counter_iot/const_string.dart';
import 'package:counter_iot/view/Widgets/widget%20controller/sensor_status_box_controller.dart';
import 'package:flutter/material.dart';


class SensorBoxStatus extends StatelessWidget {
  SensorBoxStatus({
    Key? key,
    this.vehicleNumber,
    required this.lnFlag,
    required this.editVehicleNum,
    required this.counterReadingSwitch,
    required this.sensorStatus
  }) : super(key: key);
  final bool lnFlag;
  final String? vehicleNumber;
  final Function() editVehicleNum;
  final Function(bool val) counterReadingSwitch;
  final bool sensorStatus;

  

  @override
  Widget build(BuildContext context) {
    log(sensorStatus.toString());
    return Container(
      width: 190,
      decoration: decoration,
      child: Center(
        child: Column(children: [
          heading("first line"),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Column(children: [
              lnFlag ? vehicleNumberDesign(flag: true,editVehicleNum: editVehicleNum,vehicleNum: vehicleNumber) : const SizedBox(),
              lnFlag
                  ? sensorSwitchSection(onChange: counterReadingSwitch, val: sensorStatus)
                  : const SizedBox(),
              dropCount()
            ]),
          )
        ]),
      ),
    );
  }

// todo: sensor heading start
  Widget heading(String line) {
    return Container(
      padding: const EdgeInsets.only(left: 18),
      height: 50,
      decoration: BoxDecoration(
          color: colorsList(colorsList: ColorsLists.gray),
          borderRadius: BorderRadius.all(radiusTen)),
      child: Row(
        children: [
          Center(child: Text(line)),
        ],
      ),
    );
  }
// ! sensor heading end

// todo: vehicle number start
  // Widget vehicleNumberController(context,vehicleNumber) {
  //   return Consumer<SensorStatusBoxController>(
  //       builder: (context, myModel, child) {
  //     return vehicleNumberDesign(
  //         flag: myModel.flag,
  //         onClick: () {
  //           myModel.flag ? myModel.changeFlag(false) : myModel.changeFlag(true);
  //         },
  //         vehicleNum: vehicleNumber);
  //   });
  // }

  Widget vehicleNumberDesign({required flag, required editVehicleNum,vehicleNum = 'vehicle Number'}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        flag
            ? const SizedBox(width: 120, child: TextField())
            : Text(vehicleNum),
        IconButton(
            onPressed: editVehicleNum, icon: const Icon(Icons.edit_road_outlined))
      ],
    );
  }
// ! vehicle number end

// todo: sensor switch section start
  Widget sensorSwitchSection({required Function(bool) onChange, required val}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(counterName),
        Switch(value: val, onChanged:onChange)
      ],
    );
  }
// ! sensor switch section end

// todo: Drop count section start
  Widget dropCount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(totalDrops),
        const Text("data"),
      ],
    );
  }
// ! Drop count section end

// todo: sensor decoration start
  final BoxDecoration decoration = BoxDecoration(
      color: colorsList(
        colorsList: ColorsLists.backgroundColor,
      ),
      borderRadius: BorderRadius.all(radiusTen));
// ! sensor decoration end
}
