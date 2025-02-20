import 'package:flutter/material.dart';
import '../../../data/models/profile_get/skills_model.dart';
import 'profile_item.dart';

class SkillCard extends StatelessWidget {
  final GetSkill skill;
  const SkillCard({
    Key? key,
    required this.skill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          boxShadow: [
            const BoxShadow(
               // color: AppColors.primary.withOpacity(0.1),
                blurRadius: 5.0,
                spreadRadius: 0.0,
                blurStyle: BlurStyle.outer,
                offset: Offset(0, 1))
          ],
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10.0),
          // border: BorderDirectional(
          //     top: BorderSide(color: AppColors.primary, width: 5.0),
          //     bottom: BorderSide(color: AppColors.primary, width: 5.0)),
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileItem(kkey: "skill_name", value: skill.skillName!),
          ProfileItem(kkey: "skill_level", value: skill.skillLevel!),
        ],
      ),
    );
  }
}
