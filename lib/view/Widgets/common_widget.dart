import 'dart:developer';

import 'package:counter_iot/DB/db_helper.dart';
import 'package:counter_iot/const_file.dart';
import 'package:counter_iot/controller/db/database_controller.dart';
import 'package:counter_iot/view/Widgets/app_bar.dart';
import 'package:counter_iot/view/Widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/db_model.dart';

class WidgetTest extends StatefulWidget {
  const WidgetTest({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<WidgetTest> createState() => _WidgetTestState();
}

class _WidgetTestState extends State<WidgetTest> {
  final int _counter = 0;
  @override
  void initState() {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);
    super.initState();
  }

  @override
  void dispose() {
    server.close();
    super.dispose();
  }
  // ! this is important
  // * this is working properly
  // ? this id done
  // todo :

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(actions: [], titles: ""),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              buttonSelect(
                  context: context,
                  onTap: () {},
                  buttonType: ButtonType.acceptButton),
              space20,
              buttonSelect(
                  context: context,
                  onTap: () {},
                  buttonType: ButtonType.denyButton),
              space20,
              buttonSelect(
                  context: context,
                  onTap: () {},
                  buttonType: ButtonType.jnAddSensor),
              space20,
              buttonSelect(
                  context: context,
                  onTap: () {},
                  buttonType: ButtonType.lnAddSensor),
              space20,
              buttonSelect(
                  context: context,
                  onTap: () {},
                  buttonType: ButtonType.secondAddSensor),
              space20,
              // SensorBoxStatus(lnFlag: true),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // List<SensorModel> val = [];
          await addModelToDb();
          Provider.of<DatabaseController>(context, listen: false)
              .refreshSensor();
          // print(Provider.of<DatabaseController>(context,listen: false).deviceModel.length);

          final data = Provider.of<DatabaseController>(context, listen: false)
              .deviceModel;
          for (var i = 0; i < data.length; i++) {
            log("dddddddddddddddddddddddddddd ${data[i].sensorId}");
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future addModelToDb() async {
    final sensorModel = SensorModel(
        sensorId: "123456783",
        sensorType: "UL",
        sensorSlno: "20",
        sensorCode: "987654321");
    await DatabaseHelper.instance.addValuesToAllFields(sensorModel);
  }
}
