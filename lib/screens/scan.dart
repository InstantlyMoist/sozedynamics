import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sozedynamics/utils/file_handler.dart';
import 'package:sozedynamics/utils/modal_shower.dart';
import 'package:sozedynamics/widgets/result_tile.dart';
import 'package:sozedynamics/widgets/sheets/connection_sheet.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
  List<BluetoothDiscoveryResult> _results = [];
  late FileHandler _fileHandler;
  String _scanned = "X";

  @override
  void initState() {
    super.initState();
    _fileHandler = FileHandler();
  }

  loadScanned() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.manageExternalStorage,
      Permission.storage,
    ].request();

    _scanned = await _fileHandler.readFromFile() ?? "0";
  }

  incrementScanned() async {
    _scanned = (int.parse(_scanned) + 1).toString();
    _fileHandler.writeToFile(_scanned);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    loadScanned();
    discover();
  }

  /// Discover nearby bluetooth devices

  void discover() {
    _results = [];
    if (_streamSubscription != null) _streamSubscription!.cancel();
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen(
      (r) {
        setState(
          () {
            if (r.device.name == null || r.device.name!.isEmpty) return;
            final existingIndex = _results.indexWhere(
                (element) => element.device.address == r.device.address);

            if (existingIndex >= 0) {
              _results[existingIndex] = r;
            } else {
              _results.add(r);
              incrementScanned();
            }
          },
        );
        if (r.device.name == "SozeDynamics") {
          // The device found is a SozeDynamics robot, show dialog
          ModalShower().showModalSheet(
            context,
            ConnectionSheet(
              result: r,
            ),
          );
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
              Text(
                  "In totaal zijn er ${_scanned} apparaten gescand"),
              for (BluetoothDiscoveryResult result in _results)
                ResultTile(result: result),
            ],
          ),
        ),
      ),
    );
  }
}
