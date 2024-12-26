import 'package:flutter/material.dart';
import '../../../data/models/profile_get/achievements_model.dart';
import 'custom_profile_text.dart';

class AchievementCard extends StatelessWidget {
  final GetAchievement achievement;
  const AchievementCard({
    Key? key,
    required this.achievement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                //color: AppColors.primary.withOpacity(0.1),
                blurRadius: 0.0,
                spreadRadius: 0.0,
                blurStyle: BlurStyle.outer,
                offset: Offset(0, 1))
          ],
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16.0),
          // border: BorderDirectional(
          //     top: BorderSide(color: AppColors.primary, width: 5.0),
          //     bottom: BorderSide(color: AppColors.primary, width: 5.0))
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         CustomProfileText(text: achievement.achievementText!)
        ],
      ),
    );
  }
}
