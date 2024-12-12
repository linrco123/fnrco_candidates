import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/profile_update/work_experiences.dart';
import 'package:fnrco_candidates/logic/cubit/profile_update/experience/experience_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_drop_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/auth/signup/signup_loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile/custom_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/profile/title_text.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExperienceCubit(ExperienceProvider())..getCountries(),
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, 'work_experience'),
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(),
          centerTitle: true,
        ),
        body: BlocConsumer<ExperienceCubit, ExperienceState>(
          listener: (context, state) {
            if (state is CheckExperienceEmptyFieldsState) {
              showToast(context,
                  title: translateLang(context, 'warning'),
                  desc:
                      translateLang(context, "msg_plz_chse_experience_fields"),
                  type: ToastificationType.warning);
            }
            if (state is SubmitWorkExperienceSuccessState) {
              showToast(context,
                  title: translateLang(context, 'success'),
                  desc: translateLang(context, "msg_experience_add_success"),
                  type: ToastificationType.success);
              Navigator.of(context).pop();
            }
            if (state is SubmitWorkExperienceFailureState) {
              showToast(context,
                  title: translateLang(context, 'error'),
                  desc: state.message,
                  type: ToastificationType.error);
            }
          },
          builder: (context, state) {
            ExperienceCubit experiencesCubit = BlocProvider.of(context);
            if (state is ExperiencesGettingCountriesLoadingState)
              return AnimatedLoadingWidget();
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Column(
                children: [
                  Expanded(
                    child: Form(
                      key: experiencesCubit.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          state is ExperiencesGettingCountriesLoadingState
                              ? SignUpLoadingWidget()
                              : CustomDropTextField(
                                  items: experiencesCubit.countries
                                      .map((country) => DropdownMenuItem<int>(
                                            //alignment: Alignment.center,
                                            child:
                                                Text('${country.countryName}'),
                                            value: country.id,
                                          ))
                                      .toList(),
                                  text:
                                      translateLang(context, 'select_country'),
                                  icon: Icon(
                                    CupertinoIcons.building_2_fill,
                                    color: AppColors.grey,
                                  ),
                                  onChanged: (skill) =>
                                      experiencesCubit.selectCountry(
                                          int.parse(skill.toString()))),
                          const SizedBox(
                            height: 16.0,
                          ),

                          CustomTitle(title: 'job_title'),
                          CustomInputField(
                            controller: experiencesCubit.jobTitleCntroller,
                            validate: experiencesCubit.validateJobTitle,
                            hint: translateLang(context, 'job_title'),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),

                          CustomTitle(title: 'company_name'),
                          CustomInputField(
                            controller: experiencesCubit.companyCntroller,
                            validate: experiencesCubit.validateCompany,
                            hint: translateLang(context, 'company_name'),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          CustomTitle(title: 'start_date'),
                          GestureDetector(
                            onTap: () {
                              experiencesCubit.selectStartDate(context);
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              width: double.infinity,
                              height: 50.0,
                              decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16.0)),
                              child: Row(
                                children: [
                                  Text(
                                    experiencesCubit.startDate ??
                                        translateLang(context, 'start_date'),
                                    style: TextStyle(
                                        color:
                                            experiencesCubit.startDate == null
                                                ? AppColors.grey
                                                : AppColors.black),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    CupertinoIcons.calendar,
                                    size: 25.0,
                                    color: AppColors.grey,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                       
                          CustomTitle(title: 'end_date'),
                          GestureDetector(
                            onTap: () {
                              experiencesCubit.selectEndDate(context);
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              width: double.infinity,
                              height: 50.0,
                              decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16.0)),
                              child: Row(
                                children: [
                                  Text(
                                    experiencesCubit.endDate ??
                                        translateLang(context, 'end_date'),
                                    style: TextStyle(
                                        color: experiencesCubit.endDate == null
                                            ? AppColors.grey
                                            : AppColors.black),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    CupertinoIcons.calendar,
                                    size: 25.0,
                                    color: AppColors.grey,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                         
                          CustomTitle(title: 'job_desc'),
                          CustomInputField(
                            linesNum: 3,
                            controller: experiencesCubit.jobDescCntroller,
                            validate: experiencesCubit.validateDescription,
                            hint: translateLang(context, 'job_desc'),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: CustomElevatedButton(
                                fun: () {
                                  experiencesCubit.addNewExperience();
                                },
                                background: AppColors.black,
                                text: 'add New Experience'),
                          ),
                          // const Spacer(),
                          // const SizedBox(
                          //   height: 10.0,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  state is SubmitWorkExperienceLoadingState
                      ? LoadingWidget()
                      : CustomElevatedButton(
                          fun: () {
                            experiencesCubit.submitWorkExperience();
                          },
                          background: AppColors.primary,
                          text: translateLang(context, 'submit')),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
