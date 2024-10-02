import 'package:flutter/material.dart';

class LOGO extends StatelessWidget {
  const LOGO({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        // color: Colors.red,
        child: Image.asset('assets/images/fnrcoerp_logo.png',
            width: 250, height: 100, fit: BoxFit.fill));
  }
}
