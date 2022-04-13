import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sozedynamics/screens/control.dart';
import 'package:sozedynamics/utils/modal_shower.dart';
import 'package:sozedynamics/utils/screen_pusher.dart';
import 'package:sozedynamics/widgets/sheets/connection_sheet.dart';
import 'package:sozedynamics/widgets/result_tile.dart';

import '../widgets/image_settings_toggle.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
  List<BluetoothDiscoveryResult> results = [];

  @override
  void initState() {
    super.initState();


  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    discover();
  }

  void discover() {
    results = [];
    if (_streamSubscription != null) _streamSubscription!.cancel();
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen(
      (r) {
        setState(
          () {
            if (r.device.name == null || r.device.name!.isEmpty) return;
            final existingIndex = results.indexWhere(
                (element) => element.device.address == r.device.address);

            if (existingIndex >= 0) {
              results[existingIndex] = r;
            } else {
              results.add(r);
            }
          },
        );
        if (r.device.name == "SozeDynamics") {
          ModalShower.showModalSheet(
            context,
            ConnectionSheet(
              result: r,
            ),
          );
          // TODO: Actually show dialog
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: discover,
        child: Icon(
          Icons.refresh,
          color: Colors.grey.shade800,
        ),
        backgroundColor: Colors.yellowAccent,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16,
              ),
              const Text(
                "SozeDynamics",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),

              const Text("Kies een SozeBot om mee te verbinden"),
              for (BluetoothDiscoveryResult result in results)
                ResultTile(result: result),

            ],
          ),
        ),
      ),
    );
  }
}
