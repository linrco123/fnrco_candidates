import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/functions/translate.dart';
import '../../../data/api_provider/profile_update/skills.dart';
import '../../../logic/cubit/profile_update/skills/skills_cubit.dart';
import '../../widgets/auth/custom_drop_text_field.dart';
import '../../widgets/auth/custom_elevated_btn.dart';
import '../../widgets/auth/signup/signup_loading_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile/custom_text_field.dart';
import '../../widgets/profile/title_text.dart';
import '../../widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class SkillsSCreen extends StatelessWidget {
  const SkillsSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SkillsCubit(SkillsProvider())..getSkills(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, 'skills'),
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(),
          centerTitle: true,
        ),
        body: BlocConsumer<SkillsCubit, SkillsState>(
          listener: (context, state) {
            if (state is CheckSkillLevelState) {
              showToast(context,
                  title: translateLang(context, 'warning'),
                  desc: translateLang(context, "msg_plz_chse_skill_v"),
                  type: ToastificationType.warning);
            }
            if (state is SubmitSkillsSuccessState) {
              showToast(context,
                  title: translateLang(context, 'success'),
                  desc: translateLang(context, "msg_skills_add_success"),
                  type: ToastificationType.success);
              Navigator.of(context).pop();
            }
            if (state is SubmitSkillsFailureState) {
              showToast(context,
                  title: translateLang(context, 'error'),
                  desc: state.message!,
                  type: ToastificationType.error);
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            SkillsCubit skillsCubit = BlocProvider.of(context);
            if (state is GettingSkillsLevelLoadingState)
              return AnimatedLoadingWidget();
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Form(
                key: skillsCubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTitle(title: 'skill_name'),
                    CustomInputField(
                      controller: skillsCubit.skillsCntroller,
                      validate: skillsCubit.validateSkill,
                      hint: translateLang(context, 'skill_name'),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    CustomTitle(title: 'skill_level'),
                    state is GettingSkillsLevelLoadingState
                        ? ItemLoadingWidget()
                        : CustomDropDownSearch(
                            selectedItem: translateLang(context, 'skill_level'),
                            items: skillsCubit.skills
                                .map((skill) => skill.metaDataText!)
                                .toList(),
                            label: translateLang(context, 'skill_level'),
                            onChanged: (skill) =>
                                skillsCubit.chooseSkill(skill!),
                          ),
                    // CustomDropTextField(
                    //     items: skillsCubit.skills
                    //         .map((skill) => DropdownMenuItem<int>(
                    //               //alignment: Alignment.center,
                    //               child: Text('${skill.metaDataText}'),
                    //               value: skill.id,
                    //             ))
                    //         .toList(),
                    //     text: translateLang(context, 'skill_level'),
                    //     icon: Icon(
                    //       CupertinoIcons.waveform_circle,
                    //       color: AppColors.grey,
                    //     ),
                    //     onChanged: (skill) => skillsCubit
                    //         .chooseSkill(int.parse(skill.toString()))),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: CustomElevatedButton(
                          fun: () {
                            skillsCubit.addNewSkill();
                          },
                          background: AppColors.black,
                          text: translateLang(context, "add_n_skill")),
                    ),
                    const Spacer(),
                    state is SubmitSkillsLoadingState
                        ? LoadingWidget()
                        : CustomElevatedButton(
                            fun: () {
                              skillsCubit.submitSkills();
                            },
                            background: AppColors.primary,
                            text: translateLang(context, 'submit')),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
