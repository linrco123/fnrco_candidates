import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ItemLoadingWidget extends StatelessWidget {
  const ItemLoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Container(
          height: 70.0,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.0)),
        ),
        baseColor: AppColors.greyDeep.withOpacity(0.1),
        highlightColor: Colors.black.withOpacity(0.03));
  }
}

//experiences-contacts-educations-credentials
//skills-languages-notes-achievements


