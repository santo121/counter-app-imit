import 'dart:developer';
import 'dart:io';
import 'package:counter_iot/DB/db_helper.dart';
import 'package:counter_iot/colors.dart';
import 'package:counter_iot/model/db_model.dart';
import 'package:counter_iot/view/Widgets/widgets_list.dart';
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
          Provider<WidgetList>(create: (_) => WidgetList())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, required this.value})
      : super(key: key);
  late ServerSocket value;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  WidgetList widgetButton = WidgetList();
  @override
  void dispose() {
    super.dispose();
    server.close();
  }

  WidgetList wid = WidgetList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        backgroundColor: buttonC(buttonColor: sensorButtonColor.primary),
      ),
      body: Center(
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
            widgetButton.buttonSelect(
              context: context,
                onTap: () {}, buttonType: ButtonType.acceptButton),
            space20,
            widgetButton.buttonSelect(
              context: context,
                onTap: () {}, buttonType: ButtonType.denyButton),
            space20,
            widgetButton.buttonSelect(
              context: context,
                onTap: () {}, buttonType: ButtonType.jnAddSensor),
            space20,
            widgetButton.buttonSelect(
              context: context,
                onTap: () {}, buttonType: ButtonType.lnAddSensor),
            space20,
            widgetButton.buttonSelect(
              context: context,
                onTap: () {}, buttonType: ButtonType.secondAddSensor),
          ],
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
