// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fnrco_candidates/constants/app_colors.dart';

class CircularPercentageIndicator extends StatelessWidget {
  final double percentage;
  final Color? color;
  final double? size;
  final double? strokeWidth;
  final Color? textColor;
  final Color?  backgroundColor;
  const CircularPercentageIndicator({
    Key? key,
    required this.percentage,
    this.color,
    this.size,
    this.strokeWidth,
    this.textColor, this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: size ?? 70.0,
          width: size ?? 70.0,
          child: CircularProgressIndicator(
            strokeAlign: BorderSide.strokeAlignCenter,
            strokeCap: StrokeCap.round,
            value: percentage / 100,
            color: color ?? AppColors.success,
            backgroundColor: backgroundColor?? AppColors.purple,
            strokeWidth: strokeWidth ?? 10.0,
          ),
        ),
        Text(
          '${percentage.toStringAsFixed(1)}%',
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: textColor ?? AppColors.grey),
        )
      ],
    );
  }
}
