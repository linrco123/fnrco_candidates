import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';

class CustomDivider extends StatelessWidget {
  final double vPadding;
  final double hPadding;
  final double dividerH;
  const CustomDivider(
      {super.key,
      this.vPadding = 15.0,
      this.hPadding = 0.0,
      this.dividerH = 1.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:   EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
      child: Divider(
        color: AppColors.primary.withOpacity(0.5),
        height: dividerH,
      ),
    );
  }
}
