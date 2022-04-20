import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sozedynamics/utils/connection_handler.dart';

class ConnectionSheet extends StatefulWidget {

  BluetoothDiscoveryResult result;

  ConnectionSheet({Key? key, required this.result}) : super(key: key);

  @override
  State<ConnectionSheet> createState() => _ConnectionSheetState();
}

class _ConnectionSheetState extends State<ConnectionSheet> {
  @override
  Widget build(BuildContext context) {
      return SizedBox(
        width: double.infinity,
        height: 240,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade800,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                children: [
                  const Text(
                    "SozeDynamics",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Image(
                        image: AssetImage("assets/images/robot.png"),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => ConnectionHandler().connect(context, true, widget.result.device.address),
                    child: Text(
                      "Verbinden",
                      style: TextStyle(color: Colors.grey.shade800),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.yellowAccent),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
