import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sozedynamics/screens/scan.dart';
import 'package:sozedynamics/widgets/drawers/control_drawer.dart';

import '../utils/screen_pusher/simple_screen_pusher.dart';



class TrickScreen extends StatefulWidget {
  BluetoothConnection connection;
  StreamSubscription? subscription;


  TrickScreen({Key? key, required this.connection, this.subscription}) : super(key: key);

  @override
  State<TrickScreen> createState() => _TrickScreenState();
}

class _TrickScreenState extends State<TrickScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SimpleScreenPusher().push(context, const ScanScreen(), false);
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black,
        drawer: ControlDrawer(
          connection: widget.connection,
          currentIndex: 1,
          subscription: widget.subscription,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                  icon: Icon(Icons.menu),
                  color: Colors.yellowAccent,
                ),
              ),
              Text("Content op het scherm"),
            ],
          ),
        ),
      ),
    );
  }
}
