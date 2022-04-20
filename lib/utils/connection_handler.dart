import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sozedynamics/main.dart';
import 'package:sozedynamics/utils/screen_pusher/simple_screen_pusher.dart';

import '../screens/control.dart';
import '../widgets/dialogs/connection_dialog.dart';

class ConnectionHandler {

  Future<void> connect(BuildContext context, bool fromDialog, String address) async {
    if (fromDialog) Navigator.of(navigatorKey.currentContext!).pop();
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (buildContext) {
        return const ConnectionDialog();
      },
    );

    try {
      BluetoothConnection connection =
      await BluetoothConnection.toAddress(address);
      Navigator.of(navigatorKey.currentContext!).pop();
      SimpleScreenPusher().push(
          navigatorKey.currentContext!, ControlScreen(connection: connection), false);
    } catch (exception) {
      Navigator.of(navigatorKey.currentContext!).pop();
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Verbinding maken gefaald"),
        ),
      );
    }
    return;
  }
}