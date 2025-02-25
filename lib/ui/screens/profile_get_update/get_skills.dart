import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/core/functions/animated_transition.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/ui/screens/profile_add_new/skills.dart';
import 'package:toastification/toastification.dart';
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
    return BlocConsumer<AboutMeCubit, AboutMeState>(
      buildWhen: (previous, current) =>
          current is AboutMeGetSkillsLoadingState ||
          current is AboutMeGetSkillsSuccessState ||
          current is AboutMeGetSkillsErrorState ||
          current is AboutMeDeleteLoadingState,
      listener: (context, state) {
        if (state is AboutMeDeleteSuccessState) {
          showToast(context,
              title: translateLang(context, 'success'),
              desc: 'skill is deleted successfully',
              type: ToastificationType.success);
          Navigator.of(context).pop();
        }
        if (state is AboutMeDeleteErrorState) {
          showToast(context,
              title: translateLang(context, 'error'),
              desc: 'skill is not deleted yet !!!',
              type: ToastificationType.error);
          //  Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is AboutMeGetSkillsLoadingState ||
            state is AboutMeDeleteLoadingState) {
          return const AnimatedLoadingWidget();
        }
        if (state is AboutMeGetSkillsErrorState) {
          return FailureWidget(
              showImage: false,
              title:
                  '${translateLang(context, "error_get_skills")}\n${state.message}',
              onTap: () {
                context.read<AboutMeCubit>().getSkills();
              });
        }

        if (state is AboutMeGetSkillsSuccessState) {
          return state.skills.isEmpty
              ? const EmptyDataWidget(
                  message: "No skills available Yet !!!",
                )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: state.skills.length,
                    itemBuilder: (context, index) => Dismissible(
                      key: Key("$index"),
                      onDismissed: (direction) {
                        context
                            .read<AboutMeCubit>()
                            .deleteSectionItem(SKILLS, state.skills[index].id!);
                      },
                      child: InkWell(
                          onTap: () {
                            animatedTransition(
                                context,
                                SkillsSCreen(
                                  skill: state.skills[index],
                                ));
                          },
                          child: SkillCard(skill: state.skills[index])),
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 16.0,
                    ),
                  ),
                );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
