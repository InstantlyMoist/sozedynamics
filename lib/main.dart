import 'package:flutter/material.dart';
import 'package:sozedynamics/screens/scan.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: const ScanScreen(),
      theme: ThemeData(
        backgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Colors.yellowAccent,
          ),
          bodyText2: TextStyle(
            color: Colors.yellowAccent,
          ),
        ).apply(
          bodyColor: Colors.yellowAccent,
          displayColor: Colors.yellowAccent,
        ),
      ),
    ),
  );
}
