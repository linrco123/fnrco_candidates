import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/profile_update/skills.dart';
import 'package:fnrco_candidates/logic/cubit/profile_update/skills/skills_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_drop_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/auth/signup/signup_loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile/custom_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/profile/title_text.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class SkillsSCreen extends StatelessWidget {
  const SkillsSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SkillsCubit(SkillsProvider())..getSkills(),
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: AppColors.white,
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
            if(state is GettingSkillsLevelLoadingState)
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
                    state is GettingSkillsLevelLoadingState?
                    SignUpLoadingWidget():
                    CustomDropTextField(
                        items: skillsCubit.skills
                            .map((skill) => DropdownMenuItem<int>(
                                  //alignment: Alignment.center,
                                  child: Text('${skill.metaDataText}'),
                                  value: skill.id,
                                ))
                            .toList(),
                        text: translateLang(context, 'skill_level'),
                        icon: Icon(
                          CupertinoIcons.waveform_circle,
                          color: AppColors.grey,
                        ),
                        onChanged: (skill) => skillsCubit
                            .chooseSkill(int.parse(skill.toString()))),
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
                          text: 'add New Skill'),
                    ),
                    const Spacer(),
                    state is SubmitSkillsLoadingState?
                    LoadingWidget():
                    CustomElevatedButton(
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
