import 'dart:developer';
import 'dart:typed_data';

import 'package:counter_iot/const_file.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ServerController with ChangeNotifier {
  List<String> value = [];

  void startServer() async {
    final server = await ServerSocket.bind(internetAddress, portNumber);
    server.listen((client) {
      handleConnection(client);
    });

    notifyListeners();
  }

  void handleConnection(Socket client) {
    log('connect from : ${client.remoteAddress.address}: ${client.remoteAddress}');
    client.listen(
      (Uint8List data) async {
        await Future.delayed(
          const Duration(seconds: 1),
        );

        final message = String.fromCharCodes(data);
        value.add(message);
        if (message == 'Knock, knock.') {
          client.write('Who is there?');
        } else if (message.length < 10) {
          client.write('$message who?');
        } else {
          client.write('Very funny.');

          client.close();
        }
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
