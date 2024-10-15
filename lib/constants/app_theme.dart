import 'package:flutter/material.dart';

import 'app_colors.dart';

final appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    textTheme: TextTheme(
        headlineSmall: TextStyle(fontSize: 15.0, color: AppColors.grey),
        headlineMedium:
            TextStyle(color: AppColors.black.withOpacity(0.7), fontSize: 16.0),
        headlineLarge: TextStyle(
            fontSize: 22.0,
            color: AppColors.black,
            fontWeight: FontWeight.bold),
        displayLarge: TextStyle(
            fontSize: 22.0,
            color: AppColors.white,
            fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: AppColors.primary, fontSize: 17.0),
        displaySmall: TextStyle(color: AppColors.primary, fontSize: 15.0),
        titleLarge: TextStyle(
            color: AppColors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
        titleMedium: TextStyle(
          color: AppColors.white,
          fontSize: 20.0,
        ),
        labelLarge: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0),
        labelSmall: TextStyle(
            fontSize: 16.0,
            color: AppColors.primary,
            fontWeight: FontWeight.bold)));
