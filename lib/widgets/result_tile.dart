import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sozedynamics/utils/connection_handler.dart';

class ResultTile extends StatefulWidget {
  BluetoothDiscoveryResult result;

  ResultTile({Key? key, required this.result}) : super(key: key);

  @override
  State<ResultTile> createState() => _ResultTileState();
}

class _ResultTileState extends State<ResultTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 12.0,
      ),
      child: GestureDetector(
        onTap: () => ConnectionHandler().connect(
            context, false, widget.result.device.address),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
          height: 64,
          child: Padding(
            padding: const EdgeInsets.all(
              12.0,
            ),
            child: Text(
              widget.result.device.name ?? "Naamloos",
            ),
          ),
        ),
      ),
    );
  }
}
