import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sozedynamics/screens/scan.dart';
import 'package:sozedynamics/utils/bluetooth_handler.dart';
import 'package:sozedynamics/utils/screen_pusher.dart';
import 'package:sozedynamics/utils/settings.dart';
import 'package:sozedynamics/widgets/image_settings_toggle.dart';
import 'package:sozedynamics/widgets/settings_toggle.dart';

import '../widgets/drawers/control_drawer.dart';

class SettingScreen extends StatefulWidget {
  BluetoothConnection connection;
  StreamSubscription? subscription;

  SettingScreen(
      {Key? key, required this.connection, required this.subscription})
      : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int _value = 255;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _value = Settings.currentMotorSpeed;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScreenPusher.pushScreen(context, const ScanScreen(), false);
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black,
        drawer: ControlDrawer(
          connection: widget.connection,
          currentIndex: 3,
          subscription: widget.subscription,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                  icon: Icon(Icons.menu),
                  color: Colors.yellowAccent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text(
                        "Motor snelheid: ${(_value / 255 * 100).toStringAsFixed(0)}%",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Slider(
                      activeColor: Colors.yellowAccent,
                      onChanged: (value) {
                        setState(() {
                          _value = value.toInt();
                        });
                        Settings.currentMotorSpeed = _value.toInt();
                        BluetoothHandler.updateMotorSpeed(
                            value, widget.connection);
                      },
                      max: 255,
                      value: _value.toDouble(),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: ImageSettingsToggle(
                    firstOption: "wiel_normaal",
                    secondOption: "wiel_mecanum",
                    title: "Wiel modus"),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: SettingsToggle(
                  firstOption: "Aan",
                  secondOption: "Uit",
                  title: "Lidar status",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
