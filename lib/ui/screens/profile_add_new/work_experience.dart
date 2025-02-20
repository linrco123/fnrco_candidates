// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import 'package:fnrco_candidates/data/models/profile_get/experiences_model.dart';

import '../../../constants/app_colors.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/functions/translate.dart';
import '../../../data/api_provider/profile_update/work_experiences.dart';
import '../../../logic/cubit/profile_update/experience/experience_cubit.dart';
import '../../widgets/auth/custom_drop_text_field.dart';
import '../../widgets/auth/custom_elevated_btn.dart';
import '../../widgets/auth/signup/signup_loading_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile/custom_text_field.dart';
import '../../widgets/profile/date_picker_widget.dart';
import '../../widgets/profile/title_text.dart';
import '../../widgets/return_btn.dart';

class ExperienceScreen extends StatelessWidget {
  final GetExperience? experience;
  const ExperienceScreen({
    Key? key,
    this.experience,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExperienceCubit(ExperienceProvider())
        ..getCountries()
        ..fillFields(experience),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, 'work_experience'),
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(),
          centerTitle: true,
        ),
        floatingActionButton: experience != null
            ? null
            : Builder(builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.06),
                  child: FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<ExperienceCubit>(context)
                          .addNewExperience();
                    },
                    child: const Icon(CupertinoIcons.add),
                  ),
                );
              }),
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
              return const AnimatedLoadingWidget();
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Column(
                children: [
                  Expanded(
                    child: Form(
                      key: experiencesCubit.formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            state is ExperiencesGettingCountriesLoadingState
                                ? const ItemLoadingWidget()
                                : CustomDropDownSearch(
                                    isSearchEnabled: true,
                                    label: translateLang(
                                        context, 'select_country'),
                                    items: experiencesCubit.countries
                                        .map((country) => country.countryName!)
                                        .toList(),
                                    selectedItem: experiencesCubit.countryId,
                                    onChanged: (value) =>
                                        experiencesCubit.selectCountry(value!),
                                  ),

                            const SizedBox(
                              height: 16.0,
                            ),

                            const CustomTitle(title: 'job_title'),
                            CustomInputField(
                              controller: experiencesCubit.jobTitleCntroller,
                              validate: experiencesCubit.validateJobTitle,
                              hint: translateLang(context, 'job_title'),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),

                            const CustomTitle(title: 'company_name'),
                            CustomInputField(
                              controller: experiencesCubit.companyCntroller,
                              validate: experiencesCubit.validateCompany,
                              hint: translateLang(context, 'company_name'),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            const CustomTitle(title: 'start_date'),
                            //
                            CustomDatePicker(
                              onTap: () {
                                experiencesCubit.selectStartDate(context);
                              },
                              text: experiencesCubit.startDate ??
                                  translateLang(context, 'start_date'),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),

                            const CustomTitle(title: 'end_date'),
                            CustomDatePicker(
                              onTap: () {
                                experiencesCubit.selectEndDate(context);
                              },
                              text: experiencesCubit.endDate ??
                                  translateLang(context, 'end_date'),
                            ),

                            const SizedBox(
                              height: 16,
                            ),

                            CustomInputField(
                              linesNum: 3,
                              controller: experiencesCubit.jobDescCntroller,
                              validate: experiencesCubit.validateDescription,
                              hint: translateLang(context, 'job_desc'),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width / 2,
                            //   child: CustomElevatedButton(
                            //       fun: () {
                            //         experiencesCubit.addNewExperience();
                            //       },
                            //       background: AppColors.black,
                            //       text:translateLang(context, "add_n_exper")),
                            // ),
                            // const Spacer(),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  state is SubmitWorkExperienceLoadingState
                      ? const AnimatedLoadingWidget()
                      : CustomElevatedButton(
                          fun: () {
                            experiencesCubit.submit();
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
