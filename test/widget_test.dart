// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sozedynamics/screens/scan.dart';
import 'package:sozedynamics/utils/bluetooth_handler.dart';
import 'package:sozedynamics/utils/settings.dart';

void main() {
  test("String gets converted correctly to UINT8LIST", () {
    String toConvert = "Hello, world!";
    Uint8List converted = BluetoothHandler.convertStringToUint8List(toConvert);

    expect(converted,
        [72, 101, 108, 108, 111, 44, 32, 119, 111, 114, 108, 100, 33]);
    expect(converted, isNot(equals("Hello, world!")));
  });

  test("Settings are writeable", () {
    // Test lidar settings
    expect(Settings.lidar, true);

    Settings.lidar = false;

    expect(Settings.lidar, false);

    // Test motor speed settings

    expect(Settings.currentMotorSpeed, 255);

    Settings.currentMotorSpeed -= 10;

    expect(Settings.currentMotorSpeed, 245);

    // Test wheel state

    expect(Settings.wheelState, true);

    Settings.wheelState = false;

    expect(Settings.wheelState, false);
  });

  testWidgets('Test title gets shown correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: ScanScreen(),
    ));

    // Verify that our counter starts at 0.
    expect(find.text('SozeDynamics'), findsOneWidget);
  });
}
