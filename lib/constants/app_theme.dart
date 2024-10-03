

import 'package:flutter/material.dart';

import 'app_colors.dart';

final appTheme = ThemeData(
  textTheme: TextTheme(
    headlineSmall: TextStyle(fontSize: 15.0,color: AppColors.grey),
    headlineMedium: TextStyle(color: AppColors.black.withOpacity(0.7) ,fontSize: 16.0),
    headlineLarge: TextStyle(fontSize: 22.0 , color: AppColors.black, fontWeight: FontWeight.bold),
  )
);
