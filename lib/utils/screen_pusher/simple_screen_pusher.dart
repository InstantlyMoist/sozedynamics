import 'package:flutter/material.dart';

import '../screen_pusher/base_screen_pusher.dart';

class SimpleScreenPusher implements ScreenPusher {

  @override
  void push(context, route, shouldPop) {
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
