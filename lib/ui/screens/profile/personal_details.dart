import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/profile_update/personal_details.dart';
import 'package:fnrco_candidates/logic/cubit/profile_update/personal_data/personal_details/personal_details_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_drop_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/auth/signup/signup_loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile/custom_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/profile/date_picker_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile/profile_pic.dart';
import 'package:fnrco_candidates/ui/widgets/profile/title_text.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonalDetailsCubit(
          personalDetailsProvider: PersonalDetailsProvider())
        ..getCountries()
        ..getGenders()
        ..getReligions()
        ..getMaritalStatus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, 'personal_details'),
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(),
          centerTitle: true,
        ),
        backgroundColor: AppColors.white,
        body: LayoutBuilder(builder: (context, constraints) {
          return BlocConsumer<PersonalDetailsCubit, PersonalDetailsState>(
            listener: (context, state) {
              if (state is PersonalDetailsSuccessState) {
                showToast(context,
                    title: translateLang(context, 'success'),
                    desc: translateLang(context, 'msg_p_Dets_sav_success'),
                    type: ToastificationType.success);
                Navigator.of(context).pop();
              }
              if (state is PersonalDetailsErrorState) {
                showToast(context,
                    title: translateLang(context, 'error'),
                    desc: state.message,
                    type: ToastificationType.error);
              }
            },
            builder: (context, state) {
              final PersonalDetailsCubit personalDetailsCubit =
                  BlocProvider.of(context);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.04),
                    ProfilePic(
                      file: CacheHelper.getImage() == null ? false : true,
                      image: CacheHelper.getImage() ?? AppImages.User,
                      imageUploadBtnPress:
                          personalDetailsCubit.changeProfileImage,
                    ),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    Form(
                      key: personalDetailsCubit.formKey,
                      child: Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CustomTitle(
                                title: "first_name",
                              ),
                              CustomInputField(
                                  controller:
                                      personalDetailsCubit.firstNameController,
                                  validate:
                                      personalDetailsCubit.validateFirstName,
                                  inputType: TextInputType.name,
                                  hint: translateLang(context, "first_name")),
                              const SizedBox(
                                height: 16.0,
                              ),
                              CustomTitle(
                                title: "second_name",
                              ),
                              CustomInputField(
                                  controller:
                                      personalDetailsCubit.secondNameController,
                                  validate:
                                      personalDetailsCubit.validateSecondName,
                                  inputType: TextInputType.name,
                                  hint: translateLang(context, "second_name")),
                              const SizedBox(
                                height: 16.0,
                              ),
                              CustomTitle(
                                title: "last_name",
                              ),
                              CustomInputField(
                                  controller:
                                      personalDetailsCubit.lastNameController,
                                  validate:
                                      personalDetailsCubit.validateLastName,
                                  inputType: TextInputType.name,
                                  hint: translateLang(context, "last_name")),
                              const SizedBox(
                                height: 16.0,
                              ),
                              CustomTitle(
                                title: "sur_name",
                              ),
                              CustomInputField(
                                  controller:
                                      personalDetailsCubit.surNameController,
                                  validate:
                                      personalDetailsCubit.validateSurName,
                                  inputType: TextInputType.name,
                                  hint: translateLang(context, "sur_name")),
                              const SizedBox(
                                height: 16.0,
                              ),
                              CustomTitle(
                                title: "email",
                              ),
                              CustomInputField(
                                  controller:
                                      personalDetailsCubit.emailController,
                                  validate: personalDetailsCubit.validateEmail,
                                  inputType: TextInputType.emailAddress,
                                  hint: translateLang(context, "email")),
                              const SizedBox(
                                height: 16.0,
                              ),
                              CustomTitle(
                                title: "residence",
                              ),
                              CustomInputField(
                                  controller: personalDetailsCubit
                                      .countryResidenceController,
                                  validate:
                                      personalDetailsCubit.validateResidence,
                                  inputType: TextInputType.name,
                                  hint: translateLang(context, "residence")),
                              const SizedBox(
                                height: 16.0,
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     personalDetailsCubit
                              //         .selectDateOfBirth(context);
                              //   },
                              //   child: Container(
                              //     padding: const EdgeInsets.symmetric(
                              //         horizontal: 20.0, vertical: 25.0),
                              //     width: double.infinity,
                              //     // height: 50.0,
                              //     decoration: BoxDecoration(
                              //         border: Border.all(
                              //             color: Colors.grey.shade300),
                              //         color: AppColors.white,
                              //         borderRadius:
                              //             BorderRadius.circular(16.0)),
                              //     child: Row(
                              //       children: [
                              //         Text(
                              //           personalDetailsCubit.birthDate ??
                              //               translateLang(
                              //                   context, 'date_birth'),
                              //           style: Theme.of(context)
                              //               .textTheme
                              //               .labelMedium,
                              //         ),
                              //         const Spacer(),
                              //         Icon(
                              //           CupertinoIcons.calendar,
                              //           size: 25.0,
                              //           color: AppColors.primary,
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              CustomDatePicker(
                                  onTap: () {
                                    personalDetailsCubit
                                        .selectDateOfBirth(context);
                                  },
                                  text: personalDetailsCubit.birthDate ??
                                      translateLang(context, 'date_birth')),
                              const SizedBox(
                                height: 16.0,
                              ),
                              personalDetailsCubit.countries.isEmpty
                                  ? SignUpLoadingWidget()
                                  : CustomDropDownSearch(
                                      label: translateLang(
                                          context, 'select_country'),
                                      items: personalDetailsCubit.countries
                                          .map(
                                              (country) => country.countryName!)
                                          .toList(),
                                      selectedItem:
                                          translateLang(context, 'country'),
                                      onChanged: (value) => personalDetailsCubit
                                          .selectCountry(value!),
                                    ),

                              const SizedBox(
                                height: 16.0,
                              ),
                              personalDetailsCubit.genders.isEmpty
                                  ? SignUpLoadingWidget()
                                  : CustomDropDownSearch(
                                      isSearchEnabled: false,
                                      label: translateLang(
                                          context, 'select_gender'),
                                      items: personalDetailsCubit.genders
                                          .map((gender) => gender.metaDataText!)
                                          .toList(),
                                      selectedItem:
                                          translateLang(context, 'gender'),
                                      onChanged: (value) => personalDetailsCubit
                                          .selectGender(value!),
                                    ),

                              const SizedBox(
                                height: 16.0,
                              ),
                              personalDetailsCubit.religions.isEmpty
                                  ? SignUpLoadingWidget()
                                  : CustomDropDownSearch(
                                      label: translateLang(
                                          context, 'select_religion'),
                                      items: personalDetailsCubit.religions
                                          .map((religion) =>
                                              religion.religionName!)
                                          .toList(),
                                      selectedItem:
                                          translateLang(context, 'religion'),
                                      onChanged: (value) => personalDetailsCubit
                                          .selectReligion(value!),
                                    ),

                              const SizedBox(
                                height: 16.0,
                              ),
                              personalDetailsCubit.maritalStatus.isEmpty
                                  ? SignUpLoadingWidget()
                                  : CustomDropDownSearch(
                                      label: translateLang(
                                          context, 'select_marital_status'),
                                      items: personalDetailsCubit.maritalStatus
                                          .map((marital) =>
                                              marital.metaDataText!)
                                          .toList(),
                                      selectedItem: translateLang(
                                          context, 'marital_status'),
                                      onChanged: (value) => personalDetailsCubit
                                          .selectMaritalStatus(value!),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    state is PersonalDetailsLoadingState
                        ? LoadingWidget()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: CustomElevatedButton(
                                fun: () {
                                  personalDetailsCubit
                                      .submitPersonalData(context);
                                },
                                background: AppColors.primary,
                                text: translateLang(context, 'save'))),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
    ;
  }
}
