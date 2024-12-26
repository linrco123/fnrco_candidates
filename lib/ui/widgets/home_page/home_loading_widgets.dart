import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class LoadingJobCardHome extends StatelessWidget {
  const LoadingJobCardHome({super.key});
  //c 130-200 c 95 inf
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.grey.withOpacity(0.2),
      highlightColor: Colors.black.withOpacity(0.03),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(16.0)),
        height: 95.0,
        width: double.infinity,
      ),
    );
  }
}

class LoadingSingleHomeCard extends StatelessWidget {
  const LoadingSingleHomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey.withOpacity(0.2),
      highlightColor: Colors.black.withOpacity(0.03),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(16.0)),
        height: 130.0,
        width: 200,
      ),
    );
  }
}



