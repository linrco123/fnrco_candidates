import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/functions/translate.dart';
import '../../../logic/cubit/profile_get/about_me/about_me_cubit.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile_get/skill_card.dart';

class GetSkillsScreen extends StatefulWidget {
  const GetSkillsScreen({super.key});

  @override
  State<GetSkillsScreen> createState() => _GetPersonalDetailsScreenState();
}

class _GetPersonalDetailsScreenState extends State<GetSkillsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AboutMeCubit>().getSkills();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutMeCubit, AboutMeState>(
      builder: (context, state) {
        if (state is AboutMeGetSkillsLoadingState) {
          return AnimatedLoadingWidget();
        }
        if (state is AboutMeGetSkillsErrorState) {
          return FailureWidget(
              showImage: false,
              title: translateLang(context, "error_get_skills"),
              onTap: () {
                context.read<AboutMeCubit>().getSkills();
              });
        }
        if (state is AboutMeGetSkillsSuccessState) {
          return state.skills.isEmpty
              ? EmptyDataWidget(
                message: "No skills available Yet !!!",
              )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: state.skills.length,
                    itemBuilder: (context, index) =>
                        SkillCard(skill: state.skills[index]),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 16.0,
                    ),
                  ),
                );
        }
        return SizedBox.shrink();
      },
    );
  }
}
