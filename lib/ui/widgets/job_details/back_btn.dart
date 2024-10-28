import 'package:flutter/material.dart';

class CustomBackBTN extends StatelessWidget {
  final Color btnColor;

  final Color arrowColor;

  CustomBackBTN({super.key, required this.btnColor, required this.arrowColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Container(
          // alignment: Alignment.center,
          decoration: BoxDecoration(color: btnColor, shape: BoxShape.circle),
          padding: const EdgeInsets.all(10.0),
          child: Icon(Icons.keyboard_backspace_rounded, color: arrowColor),
        ));
  }
}
