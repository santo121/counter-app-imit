import 'dart:async';
import 'dart:io';
import 'package:counter_iot/DB/db_helper.dart';
import 'package:counter_iot/const_file.dart';
import 'package:counter_iot/controller/db/database_controller.dart';
import 'package:counter_iot/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/server/server_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // late ServerSocket server;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      // open server
      // server = await ServerSocket.bind(internetAddress, portNumber);
      // server.listen((client) {
      //   Provider.of<ServerController>(context, listen: false)
      //       .handleConnection(client);
      // });
      // sensor controller
     final val = Provider.of<DatabaseController>(context, listen: false).refreshSensor();
    //  print(val.then((value) => value[0]));
    });
    Timer(
      const Duration(seconds: 8),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WidgetTest(title: 'it is testing now'),
        ),
      ),
    );
  }

 
@override
  void dispose() {
    // DatabaseHelper.instance.close();

    super.dispose();
  }
  @override  
  Widget build(BuildContext context) {
                                                 

    return Scaffold(
        body: Container(
      child: Center(
          child: ElevatedButton(
        child: const Text("data"),
        onPressed: () {
          // Provider.of<DatabaseController>(context, listen: false)
          //     .addSensorData();
        },
      )),
    ));
  }
}
