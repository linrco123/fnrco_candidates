import 'dart:io';

import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

void confirmExit(context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
        backgroundColor: AppColors.primary,
        title: Text(
          'Alert',
          style: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              //decoration: TextDecoration.underline,
              color: Colors.white),
        ),
        content: Text(
          'Do you wanna close the app ?',
          style: const TextStyle(fontSize: 15.0, color: Colors.white),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                exit(0);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('Ok'),
              )),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel')),
        ]),
  );
}
