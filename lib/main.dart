import 'dart:io';
import 'package:counter_iot/view/Widgets/common_widget.dart';
import 'package:counter_iot/view/Widgets/widget%20controller/sensor_status_box_controller.dart';
import 'package:counter_iot/view/screens/home/home_screen.dart';
import 'package:counter_iot/view/screens/home/home_screen_controller.dart';
import 'package:counter_iot/view/screens/sensor%20creating%20screen/sensor_createing_page.dart';
import 'package:counter_iot/view/screens/sensor%20creating%20screen/sensor_creating_controller.dart';
import 'package:counter_iot/view/screens/sensor%20reading%20screen/senor_reading_controller.dart';
import 'package:counter_iot/view/screens/sensor%20reading%20screen/sensor_reading_signal.dart';
import 'package:counter_iot/view/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'const_file.dart';
import 'controller/db/database_controller.dart';
import 'controller/server/server_controller.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations;
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Provider.debugCheckInvalidValueType = null;
  DatabaseController db = DatabaseController();
  await db.initializeDataBase();

  ServerController sC = ServerController();

  server = await ServerSocket.bind(internetAddress, portNumber);
  server.listen((event) {
    sC.handleConnection(event);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MultiProvider(
        providers: [
          Provider<ServerController>(create: (_) => ServerController()),
          Provider<DatabaseController>(create: (_) => DatabaseController()),
          ChangeNotifierProvider(create: (_) => SensorStatusBoxController()),
          ChangeNotifierProvider(create: (_) => SensorCreatingController()),
          ChangeNotifierProvider(create: (_) => HomeScreenController()),
          ChangeNotifierProvider(create: (_) => SensorReadingController()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/': ((context) => const WidgetTest(
                  title: 'title',
                )),
            '/splash': ((context) => const SplashScreen()),
            '/home_screen': ((context) => const HomeScreen()),
            '/create_sensor': ((context) => const SensorCreationPage()),
            '/sensor_reading': ((context) => const SensorReadingSignal()),
          },
          initialRoute: '/splash',
        ));
  }
}

