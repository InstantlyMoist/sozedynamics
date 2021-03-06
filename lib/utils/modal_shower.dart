import 'package:flutter/material.dart';

class ModalShower {

  Future<void> showModalSheet(BuildContext context, Widget sheet) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (_) => sheet);
    return;
  }
}
