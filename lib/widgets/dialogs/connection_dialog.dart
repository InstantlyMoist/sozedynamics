import 'package:flutter/material.dart';

class ConnectionDialog extends StatelessWidget {
  const ConnectionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AlertDialog(
        backgroundColor: Colors.grey.shade800,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              "Aan het verbinden",
              style: TextStyle(color: Colors.yellowAccent),
            ),
            SizedBox(
              height: 16,
            ),
            CircularProgressIndicator(
              color: Colors.yellowAccent,
            )
          ],
        ),
      ),
    );
  }
}
