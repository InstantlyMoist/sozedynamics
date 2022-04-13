import 'package:flutter/material.dart';

class ControlButton extends StatelessWidget {

  VoidCallback onTapStart;
  VoidCallback onTapEnd;
  IconData icon;

  ControlButton({Key? key, required this.onTapStart, required this.icon, required this.onTapEnd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTapDown: (_) =>  onTapStart(),
        onTapUp: (_) => onTapEnd(),

        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            color: Colors.yellowAccent,
          ),
          child: Icon(icon, color: Colors.grey.shade800,),
        ),
      ),
    );
  }
}
