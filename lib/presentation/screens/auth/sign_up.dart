import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/business_logic/cubit/auth/sign_up/sign_up_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/presentation/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/presentation/widgets/auth/name_email_phone_form_field.dart';
import 'package:fnrco_candidates/presentation/widgets/auth/password_form_field.dart';

import '../../../constants/app_pages_names.dart';
import '../../widgets/logo.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return BlocConsumer<SignUpCubit, SignUpState>(
              listener: (context, state) {},
              builder: (context, state) {
                final SignUpCubit signUpCubit = BlocProvider.of(context);

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      SizedBox(height: constraints.maxHeight * 0.08),
                      const LOGO(),
                      SizedBox(height: constraints.maxHeight * 0.08),
                      Text(
                        translateLang(context, 'sign_up'),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      Form(
                        key: signUpCubit.formKey,
                        child: Column(
                          children: [
                            NameEmailPhoneFormField(
                                controller: signUpCubit.nameController,
                                inputType: TextInputType.name,
                                prefixIcon: CupertinoIcons.person,
                                hint: translateLang(context, "full_name"),
                                validate: signUpCubit.validateFullName),
                            const SizedBox(
                              height: 16.0,
                            ),
                            NameEmailPhoneFormField(
                                controller: signUpCubit.phoneController,
                                inputType: TextInputType.phone,
                                prefixIcon: CupertinoIcons.phone,
                                hint: translateLang(context, "phone_number"),
                                validate: signUpCubit.validatePhone),
                            const SizedBox(
                              height: 16.0,
                            ),
                            PasswordFormField(
                                controller: signUpCubit.passwordController,
                                obscureText: signUpCubit.obscureText,
                                prefixIcon: CupertinoIcons.lock,
                                 hint:translateLang(context, "password"),
                                toggleObscureText:
                                    signUpCubit.toggleObscureText,
                                visibleIcon: signUpCubit.getIcon(),
                                validate: signUpCubit.validatePassword),
                            const SizedBox(
                              height: 16.0,
                            ),
                            DropdownButtonFormField(
                              items: signUpCubit.countries,
                              icon: const Icon(
                                  CupertinoIcons.chevron_compact_down),
                              iconEnabledColor: AppColors.grey,
                              //value: signUpCubit.countryId,
                              onChanged: (value) =>
                                  signUpCubit.selectCountry(value!),
                              hint: Text(
                                translateLang(context, 'country'),
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              decoration: InputDecoration(
                                // hintText: translateLang(context, 'country'),
                                prefixIcon:
                                    Icon(CupertinoIcons.building_2_fill),
                                prefixIconColor: AppColors.grey,
                                alignLabelWithHint: true,
                                isDense: true,
                                helperText: 'choose your country !!',
                                helperStyle:
                                    Theme.of(context).textTheme.headlineMedium,
                                hintStyle:
                                    Theme.of(context).textTheme.headlineSmall,
                                filled: true,
                                fillColor: AppColors.blurGreen,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                              ),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: CustomElevatedButton(
                                    fun: () {},
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
                                        style:
                                            TextStyle(color: AppColors.primary),
                                      ),
                                    ],
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                            ),
                          ],
                        ),
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
