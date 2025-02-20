import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/constances.dart';
import '../../../core/functions/show_toast.dart';
import '../../../logic/cubit/auth/sign_up/sign_up_cubit.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/translate.dart';
import '../../../data/api_provider/auth/signup_provider.dart';
import '../../widgets/auth/custom_drop_text_field.dart';
import '../../widgets/auth/custom_elevated_btn.dart';
import '../../widgets/auth/name_email_phone_form_field.dart';
import '../../widgets/auth/password_form_field.dart';
import '../../widgets/auth/signup/signup_loading_widget.dart';
import '../../widgets/loading_widget.dart';
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
                if (state is SignUpSuccessState) {
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
                if (state is SignUpErrorState) {
                  showToast(context,
                      title: translateLang(context, 'error'),
                      desc: state.message,
                      type: ToastificationType.error);
                }
              },
              builder: (context, state) {
                final SignUpCubit signUpCubit = BlocProvider.of(context);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(height: constraints.maxHeight * 0.08),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.black),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            AppPagesNames.HOMEPAGE,
                                            (route) => false);
                                  },
                                  child: Text(
                                    translateLang(context, "skip"),
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )),
                            ],
                          )
                        ],
                      ),
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
                            child: Column(
                              children: [
                                NameEmailPhoneFormField(
                                    controller: signUpCubit.firstNameController,
                                    inputType: TextInputType.name,
                                    prefixIcon: CupertinoIcons.person,
                                    hint: translateLang(context, "first_name"),
                                    validate: signUpCubit.validateFirstName),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                NameEmailPhoneFormField(
                                    controller:
                                        signUpCubit.secondNameController,
                                    inputType: TextInputType.name,
                                    prefixIcon: CupertinoIcons.person,
                                    hint: translateLang(context, "second_name"),
                                    validate: signUpCubit.validateSecondName),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                NameEmailPhoneFormField(
                                    controller: signUpCubit.lastNameController,
                                    inputType: TextInputType.name,
                                    prefixIcon: CupertinoIcons.person,
                                    hint: translateLang(context, "last_name"),
                                    validate: signUpCubit.validateLastName),
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
                                NameEmailPhoneFormField(
                                    controller: signUpCubit.majorController,
                                    inputType: TextInputType.name,
                                    prefixIcon: Icons.javascript_sharp,
                                    hint: translateLang(context, "major"),
                                    validate: signUpCubit.validateMajor),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                signUpCubit.countries.isEmpty
                                    ? const ItemLoadingWidget()
                                    : CustomDropDownSearch(
                                        // widget: Icon(
                                        //   CupertinoIcons.building_2_fill,
                                        //   color: AppColors.grey,
                                        //   size: 30.0,
                                        // ),
                                        label: translateLang(
                                            context, 'select_country'),
                                        items: signUpCubit.countries
                                            .map((country) =>
                                                country.countryName!)
                                            .toList(),
                                        selectedItem:
                                            translateLang(context, 'country'),
                                        onChanged: (value) =>
                                            signUpCubit.selectCountry(value!),
                                      ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                signUpCubit.genders.isEmpty
                                    ? const ItemLoadingWidget()
                                    : CustomDropDownSearch(
                                        // widget: Image.asset(
                                        //   AppImages.gender,
                                        //   height: 20.0,
                                        //   width: 20.0,
                                        //   color: AppColors.grey,
                                        // ),
                                        isSearchEnabled: false,
                                        label: translateLang(
                                            context, 'select_gender'),
                                        items: signUpCubit.genders
                                            .map((gender) =>
                                                gender.metaDataText!)
                                            .toList(),
                                        selectedItem:
                                            translateLang(context, 'gender'),
                                        onChanged: (value) =>
                                            signUpCubit.selectGender(value!),
                                      ),

                                const SizedBox(
                                  height: 16.0,
                                ),
                                signUpCubit.religions.isEmpty
                                    ? const ItemLoadingWidget()
                                    : CustomDropDownSearch(
                                        // widget: SizedBox(
                                        //   height: 20.0,
                                        //   width: 20.0,
                                        //   child: Image.asset(
                                        //     AppImages.religion,
                                        //     color: AppColors.grey,
                                        //   ),
                                        // ),
                                        label: translateLang(
                                            context, 'select_religion'),
                                        items: signUpCubit.religions
                                            .map((religion) =>
                                                religion.religionName!)
                                            .toList(),
                                        selectedItem:
                                            translateLang(context, 'religion'),
                                        onChanged: (value) =>
                                            signUpCubit.selectReligion(value!),
                                      ),

                                const SizedBox(
                                  height: 16.0,
                                ),
                                signUpCubit.maritalStatus.isEmpty
                                    ? const ItemLoadingWidget()
                                    : CustomDropDownSearch(
                                        // widget: Image.asset(
                                        //   AppImages.marital_status,
                                        //   height: 20.0,
                                        //   width: 20.0,
                                        //   color: AppColors.grey,
                                        // ),
                                        label: translateLang(
                                            context, 'select_marital_status'),
                                        items: signUpCubit.maritalStatus
                                            .map((marital) =>
                                                marital.metaDataText!)
                                            .toList(),
                                        selectedItem: translateLang(
                                            context, 'marital_status'),
                                        onChanged: (value) => signUpCubit
                                            .selectMaritalStatus(value!),
                                      ),

                                // CustomDropTextField(
                                //     items: signUpCubit.maritalStatus
                                //         .map((marital) =>
                                //             DropdownMenuItem<int>(
                                //               //alignment: Alignment.center,
                                //               child: Text(
                                //                   '${marital.metaDataText}'),
                                //               value: marital.id,
                                //             ))
                                //         .toList(),
                                //     text: translateLang(
                                //         context, 'marital_status'),
                                //     icon: Image.asset(
                                //       AppImages.marital_status,
                                //       height: 30.0,
                                //       width: 30.0,
                                //       color: AppColors.grey,
                                //     ),
                                //     onChanged:
                                //         signUpCubit.selectMaritalStatus),
                              ],
                            ),
                          ),
                        ),
                      ),
                      state is SignUpLoadingState
                          ? const AnimatedLoadingWidget()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: CustomElevatedButton(
                                  fun: () {
                                    signUpCubit.signUp(context);
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
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: AppColors.grey),
                              children: [
                                const TextSpan(text: ' '),
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
