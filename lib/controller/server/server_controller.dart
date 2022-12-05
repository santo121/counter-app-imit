import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:counter_iot/DB/db_helper.dart';
import 'package:counter_iot/model/sensor_respose_model.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../../model/db_model.dart';

enum SensorType { lnSensor, jnSensor }
ValueNotifier <String> listNot = ValueNotifier(""); 

class ServerController extends ChangeNotifier {
String? tagId;
String? vehicleNumber;
ServerController.sn(
      {required this.sensorType, required this.verified,this.sensorId,required this.sensorCount,this.vehicleNumber});
String sensorIdList='';
  
// void changeSensorList(val){
// sensorIdList.add(val);
// notifyListeners();
// }
  void handleConnection(Socket client){
    log('connect from : ${client.remoteAddress.address}: ${client.remoteAddress}');
    final val = client.listen(
      (Uint8List data) async {
        await Future.delayed(
          const Duration(seconds: 1),
        );
        final message = String.fromCharCodes(data);
        
        //  changeSensorList(message);
        
        if(message.contains('{')){
          log('we get the message');
          

          // RecentMoneySentResponse response;
          final responseTwo = RecentMoneySentResponse.fromJson(jsonDecode(message));

          if(responseTwo.h!=null){
          client.write(DateTime.now().toString());
listNot.value=responseTwo.h!;
          notifyListeners();
 
          }else{
            log(responseTwo.d.toString());
          listNot.value=responseTwo.d!;
          tagId = responseTwo.t;
          log(tagId.toString()+" from tag");
          notifyListeners();

          }
          
          notifyListeners();


        }else{
          listNot.value=message;
        }
        


        sensorIdList=message;
        await Future.delayed(
          const Duration(seconds: 4),
        );
        listNot.value='';
        notifyListeners();

        log("checking $message");
        final val = message.split(',');
        SensorModel sm= SensorModel(sensorCode: val[0],sensorId: "1",sensorSlno: "1",sensorType: "L");
        // await DatabaseHelper.instance.addValuesToAllFields(sm);
        // final dbResponse = await DatabaseHelper.instance.readAllSensor();

        // for (int i = 0; i<dbResponse.length;i++){
        //   log(dbResponse[i].sensorCode);
        // }
        // ! pass the sensor value to the received index of list

        
          

        // if (message == 'Knock, knock.') {
        //   client.write('Who is there?');
        // } else if (message.length < 10) {
        //   client.write('$message who?');
        // } else {
        //   client.write('Very funny.');

        //   client.close();
        // }
          // log(sensorIdList.toString());

        // sensorIdList.add(message);
          // log(sensorIdList.toString());

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


//! sensor controller


  List<String> existingValJn=[];
  List<String> existingValLn=[];
  SensorType? sensorType;
  bool verified = false;
 String? sensorId='';
 int ?sensorCount;
  // ! TAB count is used for get the count of the selected tab from sensor reading screen
  int tabCount = 0;
 

  void changeSensorType({required SensorType sensorType}) {
    this.sensorType = sensorType;
    notifyListeners();
  }
  void changeExistingValJn(index,val){
    log('log for sensor index $index');
    existingValJn.insert(index,val);
    notifyListeners();
  }
  void changeExistingValLn(index,val,){
    log('log for sensor index $index');

    existingValLn.insert(index, val);
    notifyListeners();
  }
 void changeSensorId ({required val}){
  sensorId = val;
  notifyListeners();
 }

  void changeVerification({required bool verified}) {
    this.verified = verified;
    notifyListeners();
  }

  void changedTabCount(val) {
    tabCount = val;
    notifyListeners();
  }

ServerController();





}
