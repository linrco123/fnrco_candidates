// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fnrco_candidates/constants/app_colors.dart';

class LinearPercentageIndicator extends StatelessWidget {
  final double percentage;
  final Color? color;
  const LinearPercentageIndicator({
    Key? key,
    required this.percentage,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        LinearProgressIndicator(
          value: percentage/ 100,
          minHeight: 35.0,
          backgroundColor: AppColors.grey,
          color: color ?? AppColors.primary,
          borderRadius: BorderRadius.circular(16.0),
        ),
        Text(
          '${percentage.toStringAsFixed(1)}%', // Display percentage
          style: TextStyle(
            fontSize: 24,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
