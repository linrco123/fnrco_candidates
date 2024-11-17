import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/personal_data/personal_details.dart';
import 'package:fnrco_candidates/logic/cubit/personal_data/personal_details/personal_details_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_drop_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/auth/name_email_phone_form_field.dart';
import 'package:fnrco_candidates/ui/widgets/auth/signup/signup_loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:logger/logger.dart';
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
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: AppColors.primary,
              )),
          centerTitle: true,
        ),
        backgroundColor: AppColors.white,
        body: LayoutBuilder(builder: (context, constraints) {
          return BlocConsumer<PersonalDetailsCubit, PersonalDetailsState>(
            listener: (context, state) {
              if (state is PersonalDetailsSuccessState) {}
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
                    Form(
                      key: personalDetailsCubit.formKey,
                      child: Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: NameEmailPhoneFormField(
                                        controller: personalDetailsCubit
                                            .firstNameController,
                                        inputType: TextInputType.name,
                                        prefixIcon: CupertinoIcons.person,
                                        hint: translateLang(
                                            context, "first_name"),
                                        validate: personalDetailsCubit
                                            .validateFirstName),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: NameEmailPhoneFormField(
                                        controller: personalDetailsCubit
                                            .secondNameController,
                                        inputType: TextInputType.name,
                                        prefixIcon: CupertinoIcons.person,
                                        hint: translateLang(
                                            context, "second_name"),
                                        validate: personalDetailsCubit
                                            .validateSecondName),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: NameEmailPhoneFormField(
                                        controller: personalDetailsCubit
                                            .lastNameController,
                                        inputType: TextInputType.name,
                                        prefixIcon: CupertinoIcons.person,
                                        hint:
                                            translateLang(context, "last_name"),
                                        validate: personalDetailsCubit
                                            .validateLastName),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: NameEmailPhoneFormField(
                                        controller: personalDetailsCubit
                                            .surNameController,
                                        inputType: TextInputType.name,
                                        prefixIcon: CupertinoIcons.person,
                                        hint:
                                            translateLang(context, "sur_name"),
                                        validate: personalDetailsCubit
                                            .validateSurName),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              NameEmailPhoneFormField(
                                  controller:
                                      personalDetailsCubit.emailController,
                                  inputType: TextInputType.emailAddress,
                                  prefixIcon: CupertinoIcons.mail,
                                  hint: translateLang(context, "email"),
                                  validate: personalDetailsCubit.validateEmail),
                              const SizedBox(
                                height: 16.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  personalDetailsCubit
                                      .selectDateOfBirth(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  width: double.infinity,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                  child: Row(
                                    children: [
                                      Text(
                                        personalDetailsCubit.birthDate??
                                        translateLang(context, 'date_birth'),
                                        style: TextStyle(color: AppColors.grey),
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
                              personalDetailsCubit.countries.isEmpty
                                  ? SignUpLoadingWidget()
                                  : CustomDropTextField(
                                      items: personalDetailsCubit.countries
                                          .map((country) =>
                                              DropdownMenuItem<int>(
                                                //alignment: Alignment.center,
                                                child: Text(
                                                    '${country.countryName!} (${country.countryCode})'),
                                                value: country.id,
                                              ))
                                          .toList(),
                                      text: translateLang(context, 'country'),
                                      icon: Icon(
                                        CupertinoIcons.building_2_fill,
                                        color: AppColors.grey,
                                      ),
                                      onChanged:
                                          personalDetailsCubit.selectCountry,
                                    ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: personalDetailsCubit
                                              .genders.isEmpty
                                          ? SignUpLoadingWidget()
                                          : CustomDropTextField(
                                              items: personalDetailsCubit
                                                  .genders
                                                  .map((gender) =>
                                                      DropdownMenuItem<int>(
                                                        //alignment: Alignment.center,
                                                        child: Text(
                                                            '${gender.metaDataText}'),
                                                        value: gender.id,
                                                      ))
                                                  .toList(),
                                              text: translateLang(
                                                  context, 'gender'),
                                              icon: Image.asset(
                                                AppImages.gender,
                                                height: 25.0,
                                                width: 25,
                                                color: AppColors.grey,
                                              ),
                                              onChanged: personalDetailsCubit
                                                  .selectGender)),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                      child: personalDetailsCubit
                                              .religions.isEmpty
                                          ? SignUpLoadingWidget()
                                          : CustomDropTextField(
                                              items: personalDetailsCubit
                                                  .religions
                                                  .map((religion) =>
                                                      DropdownMenuItem<int>(
                                                        //alignment: Alignment.center,
                                                        child: Text(
                                                            '${religion.religionName}'),
                                                        value: religion.id,
                                                      ))
                                                  .toList(),
                                              text: translateLang(
                                                  context, 'religion'),
                                              icon: Image.asset(
                                                AppImages.religion,
                                                height: 25.0,
                                                width: 25,
                                                color: AppColors.grey,
                                              ),
                                              onChanged: personalDetailsCubit
                                                  .selectReligion)),
                                ],
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              personalDetailsCubit.maritalStatus.isEmpty
                                  ? SignUpLoadingWidget()
                                  : CustomDropTextField(
                                      items: personalDetailsCubit.maritalStatus
                                          .map((marital) =>
                                              DropdownMenuItem<int>(
                                                //alignment: Alignment.center,
                                                child: Text(
                                                    '${marital.metaDataText}'),
                                                value: marital.id,
                                              ))
                                          .toList(),
                                      text: translateLang(
                                          context, 'marital_status'),
                                      icon: Image.asset(
                                        AppImages.marital_status,
                                        height: 25.0,
                                        width: 25.0,
                                        color: AppColors.grey,
                                      ),
                                      onChanged: personalDetailsCubit
                                          .selectMaritalStatus),
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
                                text: translateLang(context, 'submit'))),
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
