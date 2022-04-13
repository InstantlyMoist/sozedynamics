import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sozedynamics/main.dart';
import 'package:sozedynamics/screens/battle.dart';
import 'package:sozedynamics/screens/control.dart';
import 'package:sozedynamics/screens/trick.dart';
import 'package:sozedynamics/utils/screen_pusher.dart';

import '../../screens/settings.dart';

class ControlDrawer extends StatefulWidget {
  BluetoothConnection connection;
  int currentIndex;
  StreamSubscription? subscription;

  ControlDrawer(
      {Key? key,
      required this.connection,
      required this.currentIndex,
      this.subscription})
      : super(key: key);

  @override
  State<ControlDrawer> createState() => _ControlDrawerState();
}

class _ControlDrawerState extends State<ControlDrawer> {
  void handleNavigation(int to) {
    if (to == widget.currentIndex) {
      Navigator.of(context).pop();
      return;
    }
    switch (to) {
      case 0:
        ScreenPusher.pushScreen(
            navigatorKey.currentContext!,
            ControlScreen(
              connection: widget.connection,
              subscription: widget.subscription,
            ),
            true);
        break;
      case 1:
        ScreenPusher.pushScreen(
            navigatorKey.currentContext!,
            BattleScreen(
              connection: widget.connection,
              subscription: widget.subscription,
            ),
            true);
        break;
      case 2:
        ScreenPusher.pushScreen(
            navigatorKey.currentContext!,
            TrickScreen(
              connection: widget.connection,
              subscription: widget.subscription,
            ),
            true);
        break;
      case 3:
        ScreenPusher.pushScreen(
            navigatorKey.currentContext!,
            SettingScreen(
              connection: widget.connection,
              subscription: widget.subscription,
            ),
            true);
        break;
      default:
        throw UnimplementedError("Scherm $to bestaat niet");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade800,
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              children: const [
                Text(
                  "SozeDynamics",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Alles kan kapot",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.control_camera,
              color: Colors.yellowAccent,
            ),
            title: Text("Bestuur robot"),
            onTap: () => handleNavigation(0),
          ),
          ListTile(
            leading: Icon(
              Icons.timelapse,
              color: Colors.yellowAccent,
            ),
            title: Text("Wedstrijd stand"),
            onTap: () => handleNavigation(1),
          ),
          ListTile(
            leading: Icon(
              Icons.motorcycle,
              color: Colors.yellowAccent,
            ),
            title: Text("Trukendoos"),
            onTap: () => handleNavigation(2),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.yellowAccent,
            ),
            title: Text("Instellingen"),
            onTap: () => handleNavigation(3),
          ),
        ],
      ),
    );
  }
}
