import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sozedynamics/main.dart';
import 'package:sozedynamics/screens/scan.dart';
import 'package:sozedynamics/utils/bluetooth_handler.dart';
import 'package:sozedynamics/widgets/control_button.dart';

import '../utils/screen_pusher.dart';
import '../widgets/drawers/control_drawer.dart';

class ControlScreen extends StatefulWidget {
  BluetoothConnection connection;
  StreamSubscription? subscription;

  ControlScreen({Key? key, required this.connection, this.subscription})
      : super(key: key);

  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  final counter = ValueNotifier<int>(0);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late OpenPainter painter;

  List<int> _buffer = [];

  void handleData(data) {
    _buffer += data;

    while (true) {
      int index = _buffer.indexOf("[".codeUnitAt(0));
      int endIndex = _buffer.indexOf("]".codeUnitAt(0), index);
      if (index >= 0 && endIndex >= 0 && endIndex > index) {
        List<int> sample = _buffer.getRange(index, endIndex).toList();
        String stringSample =
            ascii.decode(sample).replaceAll("[", "").replaceAll("]", "");

        // See if the data is angle data:
        if (stringSample.contains("A")) {
          // The data is angle data
          painter.angle = -int.parse(stringSample.replaceAll("A", ""));
          counter.value++;
          _buffer.removeRange(0, endIndex);
          return;
        }

        List<String> splitSample = stringSample.split(",");
        if (splitSample.length != 25)
          return; // Data should be 25 parts big. If it isn't the data can be considered invalid.
        painter.inputSplit = splitSample;
        counter.value++;

        _buffer.removeRange(0, endIndex);
      } else {
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    painter = OpenPainter(repaint: counter, context: context);

    print("hoi");
    if (widget.subscription == null) {
      print("new stream listening");
      widget.subscription = widget.connection.input!.listen(handleData);
    } else {
      print("on data change");
      widget.subscription!.onData(handleData);
    }

    widget.subscription!.onDone(
      () => ScreenPusher.pushScreen(context, const ScanScreen(), true),
    );
    // FIX ON DISCONNECT
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    //widget.connection.close();
    //subscription!.cancel();
  }

  bool autoDrive = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScreenPusher.pushScreen(context, const ScanScreen(), false);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.black,
          drawer: ControlDrawer(
            connection: widget.connection,
            currentIndex: 0,
            subscription: widget.subscription,
          ),
          body: Center(
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
                Container(
                  width: double.infinity,
                  height: 300,
                  color: Colors.black,
                  child: CustomPaint(
                    painter: painter,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: 300,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      ControlButton(
                        onTapStart: () =>
                            BluetoothHandler.send("s:m:tlf", widget.connection),
                        // Left turn forward
                        onTapEnd: () =>
                            BluetoothHandler.send("e:m:tlf", widget.connection),
                        // Left turn forward
                        icon: Icons.clear,
                      ),
                      ControlButton(
                        onTapStart: () =>
                            BluetoothHandler.send("s:m:f", widget.connection),
                        // Forward
                        onTapEnd: () =>
                            BluetoothHandler.send("e:m:f", widget.connection),
                        icon: Icons.arrow_drop_up,
                      ),
                      ControlButton(
                        onTapStart: () =>
                            BluetoothHandler.send("s:m:trf", widget.connection),
                        // Turn right forward
                        onTapEnd: () =>
                            BluetoothHandler.send("e:m:trf", widget.connection),
                        // Turn right forward
                        icon: Icons.clear,
                      ),
                      ControlButton(
                        onTapStart: () =>
                            BluetoothHandler.send("s:m:l", widget.connection),
                        // Left
                        onTapEnd: () =>
                            BluetoothHandler.send("e:m:l", widget.connection),
                        // Left
                        icon: Icons.arrow_left,
                      ),
                      ControlButton(
                        onTapStart: () =>
                            BluetoothHandler.send("s:m:s", widget.connection),
                        // Stop
                        onTapEnd: () =>
                            BluetoothHandler.send("e:m:s", widget.connection),
                        // Stop
                        icon: Icons.car_rental,
                      ),
                      ControlButton(
                        onTapStart: () =>
                            BluetoothHandler.send("s:m:r", widget.connection),
                        // Right
                        onTapEnd: () =>
                            BluetoothHandler.send("e:m:r", widget.connection),
                        // Right
                        icon: Icons.arrow_right,
                      ),
                      ControlButton(
                        onTapStart: () =>
                            BluetoothHandler.send("s:m:tlb", widget.connection),
                        // Turn left backward
                        onTapEnd: () =>
                            BluetoothHandler.send("e:m:tlb", widget.connection),
                        // Turn left backward
                        icon: Icons.clear,
                      ),
                      ControlButton(
                        onTapStart: () =>
                            BluetoothHandler.send("s:m:b", widget.connection),
                        // Backward
                        onTapEnd: () =>
                            BluetoothHandler.send("e:m:b", widget.connection),
                        // Backward
                        icon: Icons.arrow_drop_down,
                      ),
                      ControlButton(
                        onTapStart: () =>
                            BluetoothHandler.send("s:m:trb", widget.connection),
                        // Turn right backward
                        onTapEnd: () =>
                            BluetoothHandler.send("e:m:trb", widget.connection),
                        // Turn right backward
                        icon: Icons.two_wheeler,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.connection.output.add(ascii.encode("Hallo"));
                  },
                  child: Text("stuur data"),
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       setState(() {
                //         autoDrive = !autoDrive;
                //       });
                //       BluetoothHandler.send(
                //           !autoDrive ? "s:m:a" : "e:m:a", widget.connection);
                //     },
                //     child: Text(
                //       autoDrive ? "Automatisch rijden" : "Stoppen",
                //       style: const TextStyle(color: Colors.black),
                //     ),
                //     style: ButtonStyle(
                //         backgroundColor: MaterialStateProperty.all<Color>(
                //             Colors.yellowAccent))),
                const Spacer(),
                const SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  BuildContext context;
  AudioCache player = AudioCache(prefix: 'assets/sounds/');
  int angle = 0;

  List<String> inputSplit = [];

  OpenPainter({required Listenable repaint, required this.context})
      : super(repaint: repaint) {}

  @override
  void paint(Canvas canvas, Size size) {
    int sampleAmount;

    var paint1 = Paint()
      ..color = Colors.yellowAccent
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(MediaQuery.of(context).size.width / 2, 150), 5, paint1);

    var path = Path();

    path.moveTo(0, 0);
    path.lineTo(1.5, 0);
    path.lineTo(0, -20);
    path.lineTo(-1.5, 0);

    path.close();
    canvas.save();

    double x = 193;
    double y = 150;

    canvas.translate(x, y);
    canvas.rotate(angle * pi / 180);
    canvas.drawPath(path, paint1);
    canvas.translate(-x, -y);

    canvas.restore();

    paint1.style = PaintingStyle.stroke;
    paint1.strokeWidth = 3.0;

    double piPart = pi / 12;

    double scale = 1.4;

    for (int i = 0; i < inputSplit.length; i++) {
      double distance = double.parse(inputSplit[i]);
      if (i == 0 && distance < 20) {
        player.play("beep.mp3");
      }
      paint1.color =
          Color.lerp(Colors.redAccent, Colors.green, distance / 100)!;
      canvas.drawArc(
          Rect.fromCenter(
            center: Offset(MediaQuery.of(context).size.width / 2, 150),
            height: distance * scale,
            width: distance * scale,
          ),
          piPart * i - (piPart * 6), //radians
          piPart, //radians
          false,
          paint1);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
