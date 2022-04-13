import 'package:flutter/material.dart';

class ScreenPusher {

  static void pushScreen(BuildContext context, Widget route, bool shouldPop) {
    if (shouldPop) {
      Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => route,
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
              (route) => false);
    } else {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => route,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
  }

}