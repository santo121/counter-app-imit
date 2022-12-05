import 'dart:async';
import 'package:counter_iot/view/Widgets/common_widget.dart';
import 'package:counter_iot/view/screens/sensor%20creating%20screen/sensor_createing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]);
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      // open server
      // server = await ServerSocket.bind(internetAddress, portNumber);
      // server.listen((client) {
      //   Provider.of<ServerController>(context, listen: false)
      //       .handleConnection(client);
      // });
      // sensor controller
      // todo:  final val = Provider.of<DatabaseController>(context, listen: false).refreshSensor();
      //  print(val.then((value) => value[0]));
    });
    Timer(
      const Duration(seconds: 8),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>const SensorCreationPage(),
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
        body: Center(
            child: ElevatedButton(
          child: const Text("data"),
          onPressed: () {
            // Provider.of<DatabaseController>(context, listen: false)
            //     .addSensorData();
          },
        )));
  }
}
