import 'package:flutter/material.dart';

class LOGO extends StatelessWidget {
  const LOGO({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.red,
        child: Image.asset('assets/images/fnrcoerp_logo.png',
            width: 170, height: 70, fit: BoxFit.fill));
  }
}
