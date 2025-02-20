import 'dart:io';

import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

void confirmExit(context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Alert',
          style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              //decoration: TextDecoration.underline,
              color: Colors.white),
        ),
        content: const Text(
          'Do you wanna close the app ?',
          style: TextStyle(fontSize: 15.0, color: Colors.white),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                exit(0);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('Ok'),
              )),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel')),
        ]),
  );
}
