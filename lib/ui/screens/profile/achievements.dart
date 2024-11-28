import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/profile_update/achievements.dart';
import 'package:fnrco_candidates/logic/cubit/profile/achievements/achievements_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile/custom_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class AchievementsSCreen extends StatelessWidget {
  const AchievementsSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AchievementsCubit(AchievementsProvider()),
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, 'achievements'),
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(),
          centerTitle: true,
        ),
        body: BlocConsumer<AchievementsCubit, AchievementsState>(
          listener: (context, state) {
        
            if (state is SubmitAchievementsSuccessState) {
              showToast(context,
                  title: translateLang(context, 'success'),
                  desc: translateLang(context, "msg_achv_add_success"),
                  type: ToastificationType.success);
              Navigator.of(context).pop();
            }
            if (state is SubmitAchievementsFailureState) {
              // showToast(context,
              //     title: translateLang(context, 'error'),
              //     desc: state.message!,
              //     type: ToastificationType.error);
            }
          },
          builder: (context, state) {
            AchievementsCubit skillsCubit = BlocProvider.of(context);
          
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Form(
                key: skillsCubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translateLang(context, 'achievement'),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    CustomInputField(
                      controller: skillsCubit.achvCntroller,
                      validate: skillsCubit.validateAch,
                      linesNum: 3,
                      hint: translateLang(context, 'achievement'),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                         const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: CustomElevatedButton(
                          fun: () {
                            skillsCubit.addNewAchievement();
                          },
                          background: AppColors.black,
                          text: translateLang(context, 'add_new_ach')),
                    ),
                    const Spacer(),
                    state is SubmitAchievementsLoadingState?
                    LoadingWidget():
                    CustomElevatedButton(
                        fun: () {
                          skillsCubit.submitAchievements();
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
