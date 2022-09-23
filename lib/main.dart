import 'dart:developer';
import 'dart:io';
import 'package:counter_iot/DB/db_helper.dart';
import 'package:counter_iot/model/db_model.dart';
import 'package:counter_iot/view/Widgets/app_bar.dart';
import 'package:counter_iot/view/Widgets/buttons.dart';
import 'package:counter_iot/view/Widgets/widget%20controller/sensor_status_box.dart';
import 'package:counter_iot/view/Widgets/widget%20controller/sensor_status_box_controller.dart';
import 'package:counter_iot/view/screens/home/home_screen.dart';
import 'package:counter_iot/view/screens/sensor%20creating%20screen/sensor_createing_page.dart';
import 'package:counter_iot/view/screens/sensor%20creating%20screen/sensor_creating_controller.dart';
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
    return MultiProvider(
        providers: [
          Provider<ServerController>(create: (_) => ServerController()),
          Provider<DatabaseController>(create: (_) => DatabaseController()),
          ChangeNotifierProvider(create: (_) => SensorStatusBoxController(flag: true,switchFlag: false)),
          ChangeNotifierProvider(create: (_) => SensorCreatingController()),
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
          initialRoute: '/home_screen',
        ));
  }
}

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
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
  ]);
  }

  @override
  void dispose() {
    super.dispose();
    server.close();
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
          List<SensorModel> val = [];
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
