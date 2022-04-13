import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothHandler {

  static void send(String toSend, BluetoothConnection connection) {
    print("Sending $toSend");
    connection.output.add(convertStringToUint8List(toSend));
  }

  static void updateMotorSpeed(
      double newValue, BluetoothConnection connection) {
    //print("sending new motor speed $newValue");
    send("ms:${newValue.toInt()}", connection);
  }

  static Uint8List convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);

    return unit8List;
  }
}
