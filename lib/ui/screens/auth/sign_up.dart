import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/logic/cubit/auth/sign_up/sign_up_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/auth/signup_provider.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_drop_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/auth/name_email_phone_form_field.dart';
import 'package:fnrco_candidates/ui/widgets/auth/password_form_field.dart';
import 'package:fnrco_candidates/ui/widgets/auth/signup/signup_loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:toastification/toastification.dart';

import '../../../constants/app_pages_names.dart';
import '../../widgets/logo.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return BlocProvider(
      create: (context) => SignUpCubit(SignUpProvider())
        ..getCountries()
        ..getPositions()
        ..getGenders()
        ..getReligions()
        ..getMaritalStatus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return BlocConsumer<SignUpCubit, SignUpState>(
              listener: (context, state) {
                if (state is SignUpOTPSuccessState) {
                  Navigator.of(context)
                      .pushReplacementNamed(AppPagesNames.OTP, arguments: {
                    IDENTIFIER_KEYWORD:
                        context.read<SignUpCubit>().emailController.text,
                    PAGE_KEYWORD: SIGNUP_PAGE
                  });
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Text(
                              'code: ${state.code}',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ));
                }
                if (state is SignUpOTPFailureState) {
                  showToast(context,
                      title: 'Error',
                      desc: state.message!,
                      type: ToastificationType.error);
                }
              },
              builder: (context, state) {
                final SignUpCubit signUpCubit = BlocProvider.of(context);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SizedBox(height: constraints.maxHeight * 0.08),
                      const LOGO(),
                      SizedBox(height: constraints.maxHeight * 0.04),
                      Text(
                        translateLang(context, 'sign_up'),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      Form(
                        key: signUpCubit.formKey,
                        child: Expanded(
                          child: SingleChildScrollView(
                            child: AutofillGroup(
                              onDisposeAction:AutofillContextAction.commit,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: NameEmailPhoneFormField(
                                            controller:
                                                signUpCubit.firstNameController,
                                            inputType: TextInputType.name,
                                            prefixIcon: CupertinoIcons.person,
                                            hint: translateLang(
                                                context, "first_name" ),
                                            validate:
                                                signUpCubit.validateFullName),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Expanded(
                                        child: NameEmailPhoneFormField(
                                            controller:
                                                signUpCubit.secondNameController,
                                            inputType: TextInputType.name,
                                            prefixIcon: CupertinoIcons.person,
                                            hint: translateLang(
                                                context, "second_name"),
                                            validate:
                                                signUpCubit.validateFullName),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  NameEmailPhoneFormField(
                                      controller: signUpCubit.lastNameController,
                                      inputType: TextInputType.name,
                                      prefixIcon: CupertinoIcons.person,
                                      hint: translateLang(context,"last_name"),
                                      validate: signUpCubit.validateFullName),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  NameEmailPhoneFormField(
                                      controller: signUpCubit.emailController,
                                      inputType: TextInputType.emailAddress,
                                      prefixIcon: CupertinoIcons.mail,
                                      hint: translateLang(context, "email"),
                                      validate: signUpCubit.validateEmail),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  NameEmailPhoneFormField(
                                      controller: signUpCubit.phoneController,
                                      inputType: TextInputType.phone,
                                      prefixIcon: CupertinoIcons.phone,
                                      hint:
                                          translateLang(context, "phone_number"),
                                      validate: signUpCubit.validatePhone),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  PasswordFormField(
                                      controller: signUpCubit.passwordController,
                                      obscureText: signUpCubit.obscureText,
                                      prefixIcon: CupertinoIcons.lock,
                                      hint: translateLang(context, "password"),
                                      toggleObscureText:
                                          signUpCubit.toggleObscureText,
                                      visibleIcon: signUpCubit.getIcon(),
                                      validate: signUpCubit.validatePassword),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  signUpCubit.countries.isEmpty
                                      ? SignUpLoadingWidget()
                                      : CustomDropTextField(
                                          items: signUpCubit.countries
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
                                          onChanged: signUpCubit.selectCountry,
                                        ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  signUpCubit.positions.isEmpty
                                      ? SignUpLoadingWidget()
                                      : CustomDropTextField(
                                          onChanged: signUpCubit.selectPosition,
                                          items: signUpCubit.positions
                                              .map((position) =>
                                                  DropdownMenuItem<int>(
                                                    //alignment: Alignment.center,
                                                    child: Text(position
                                                                .positionName!
                                                                .length >
                                                            30
                                                        ? '${position.positionName!.substring(0, 30)}.........'
                                                        : position.positionName!),
                                                    value: position.id,
                                                  ))
                                              .toList(),
                                          text: 'Major',
                                          icon: Image.asset(
                                            AppImages.position1,
                                            height: 25.0,
                                            width: 25,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: signUpCubit.genders.isEmpty
                                              ? SignUpLoadingWidget()
                                              : CustomDropTextField(
                                                  items: signUpCubit.genders
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
                                                  onChanged:
                                                      signUpCubit.selectGender)),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                          child: signUpCubit.religions.isEmpty
                                              ? SignUpLoadingWidget()
                                              : CustomDropTextField(
                                                  items: signUpCubit.religions
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
                                                  onChanged: signUpCubit
                                                      .selectReligion)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  signUpCubit.maritalStatus.isEmpty
                                      ? SignUpLoadingWidget()
                                      : CustomDropTextField(
                                          items: signUpCubit.maritalStatus
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
                                          onChanged: signUpCubit.selectReligion),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      state is SignUpOTPLoadingState
                          ? LoadingWidget()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: CustomElevatedButton(
                                  fun: () {
                                    signUpCubit.getOTP();
                                  },
                                  background: AppColors.primary,
                                  text: translateLang(context, 'sign_up'))),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(AppPagesNames.LOGIN);
                        },
                        child: Text.rich(
                            TextSpan(
                              text: translateLang(
                                  context, "already_have_an_account"),
                              children: [
                                TextSpan(text: ' '),
                                TextSpan(
                                  text: translateLang(context, "sign_in"),
                                  style: TextStyle(color: AppColors.primary),
                                ),
                              ],
                            ),
                            style: Theme.of(context).textTheme.headlineSmall),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
