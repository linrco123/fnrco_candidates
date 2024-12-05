import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/data/models/profile_get/skills_model.dart';
import 'package:fnrco_candidates/ui/widgets/profile/title_text.dart';

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
            BoxShadow(
                color: AppColors.primary.withOpacity(0.1),
                blurRadius: 5.0,
                spreadRadius: 5.0,
                blurStyle: BlurStyle.outer,
                offset: Offset(0, 1))
          ],
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.0),
          border: BorderDirectional(
              top: BorderSide(color: AppColors.primary, width: 5.0),
              bottom: BorderSide(color: AppColors.primary, width: 5.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTitle(
                title: "skill_name",
              ),
              Text(
                skill.skillName!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTitle(
                title: "skill_level",
              ),
              Expanded(
                child: Text(
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  skill.skillLevel!,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
