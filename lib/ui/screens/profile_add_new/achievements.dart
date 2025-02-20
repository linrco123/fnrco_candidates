import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/functions/translate.dart';
import '../../../data/api_provider/profile_update/achievements.dart';
import '../../../logic/cubit/profile_update/achievements/achievements_cubit.dart';
import '../../widgets/auth/custom_elevated_btn.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile/custom_text_field.dart';
import '../../widgets/profile/title_text.dart';
import '../../widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class AchievementsSCreen extends StatelessWidget {
  const AchievementsSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AchievementsCubit(AchievementsProvider()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, 'achievements'),
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(),
          centerTitle: true,
        ),
        floatingActionButton: Builder(builder: (context) {
          return Padding(
            padding:  EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.08),
            child: FloatingActionButton(
              onPressed: () {
                BlocProvider.of<AchievementsCubit>(context).addNewAchievement();
              },
              child: const Icon(CupertinoIcons.add),
            ),
          );
        }),
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
                    const CustomTitle(title: 'achievement'),
                    CustomInputField(
                      controller: skillsCubit.achvCntroller,
                      validate: skillsCubit.validateAch,
                      linesNum: 10,
                      hint: translateLang(context, "enter_achievements"),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width / 2,
                    //   child: CustomElevatedButton(
                    //       fun: () {
                    //         skillsCubit.addNewAchievement();
                    //       },
                    //       background: AppColors.black,
                    //       text: translateLang(context, 'add_new_ach')),
                    // ),
                    const Spacer(),
                    state is SubmitAchievementsLoadingState
                        ? const AnimatedLoadingWidget()
                        : CustomElevatedButton(
                            fun: () {
                              skillsCubit.submit();
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
