import 'package:flutter/material.dart';
import 'package:sozedynamics/utils/screen_pusher/base_screen_pusher.dart';

class AnimatedScreenPusher implements ScreenPusher {
  @override
  void push(context, route, shouldPop) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => route,
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 2000),
      ),
    );
  }
}
