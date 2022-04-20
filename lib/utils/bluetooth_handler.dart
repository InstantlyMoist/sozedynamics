import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothHandler {

  final BluetoothConnection _connection;


  BluetoothHandler(this._connection);

  void send(String toSend) {
    if (toSend.isEmpty) throw Exception("Cannot send empty message");
    _connection.output.add(convertStringToUint8List(toSend));
  }

  void updateMotorSpeed(
      double newValue) {
    //print("sending new motor speed $newValue");

    if (newValue < 0) throw RangeError("Motor speed cannot be negative");

    // TODO: Exceptie wanneer negatief de rest ook.
    send("ms:${newValue.toInt()}");
  }

  static Uint8List convertStringToUint8List(String str) {
    final List<int> _codeUnits = str.codeUnits;
    final Uint8List _unit8List = Uint8List.fromList(_codeUnits);

    return _unit8List;
  }
}
