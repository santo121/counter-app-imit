import 'dart:developer';
import 'dart:typed_data';

import 'package:counter_iot/DB/db_helper.dart';
import 'package:counter_iot/const_file.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../../model/db_model.dart';

class ServerController with ChangeNotifier {
  List<String> value = [];

  

  void handleConnection(Socket client) {
    log('connect from : ${client.remoteAddress.address}: ${client.remoteAddress}');
    client.listen(
      (Uint8List data) async {
        await Future.delayed(
          const Duration(seconds: 1),
        );
        final message = String.fromCharCodes(data);
        log("datatatatatatatatata $message");
        value.add(message);
        final val = message.split(',');
        SensorModel sm= SensorModel(sensorCode: val[0],sensorId: "1",sensorSlno: "1",sensorType: "L");
        await DatabaseHelper.instance.addValuesToAllFields(sm);
        final dbResponse = await DatabaseHelper.instance.readAllSensor();
        for (int i = 0; i<dbResponse.length;i++){
          print(dbResponse[i].sensorCode);
        }
        

        // if (message == 'Knock, knock.') {
        //   client.write('Who is there?');
        // } else if (message.length < 10) {
        //   client.write('$message who?');
        // } else {
        //   client.write('Very funny.');

        //   client.close();
        // }
        notifyListeners();
      },
      onError: (error) {
        log(error);
        client.close();
      },
      onDone: () {
        log('Client left');
        client.close();
      },
    );
  }
}
