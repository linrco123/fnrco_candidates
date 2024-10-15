import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/business_logic/cubit/auth/sign_up/sign_up_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/presentation/widgets/auth/custom_elevated_btn.dart';

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
                            TextFormField(
                              controller: signUpCubit.nameController,
                              validator: (value) =>
                                  signUpCubit.validateFullName(context, value!),
                              decoration: InputDecoration(
                                prefixIcon: Icon(CupertinoIcons.person),
                                prefixIconColor: AppColors.grey,
                                hintText: translateLang(context, "full_name"),
                                hintStyle:
                                    Theme.of(context).textTheme.headlineMedium,
                                filled: true,
                                fillColor: AppColors.blurGreen,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0 * 1.5, vertical: 16.0),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                              ),
                              keyboardType: TextInputType.name,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            TextFormField(
                              controller: signUpCubit.phoneController,
                              validator: (value) =>
                                  signUpCubit.validatePhone(context, value!),
                              decoration: InputDecoration(
                                prefixIcon: Icon(CupertinoIcons.phone),
                                prefixIconColor: AppColors.grey,
                                hintText:
                                    translateLang(context, "phone_number"),
                                hintStyle:
                                    Theme.of(context).textTheme.headlineMedium,
                                filled: true,
                                fillColor: AppColors.blurGreen,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0 * 1.5, vertical: 16.0),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              // onSaved: (phone) {
                              //   // Save it
                              // },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: TextFormField(
                                controller: signUpCubit.passwordController,
                                obscureText: signUpCubit.obscureText,
                                validator: (value) => signUpCubit
                                    .validatePassword(context, value!),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(CupertinoIcons.lock),
                                  prefixIconColor: AppColors.grey,
                                  suffixIcon: IconButton(
                                      onPressed: signUpCubit.toggleObscureText,
                                      icon: signUpCubit.getIcon()),
                                  hintText: translateLang(context, "password"),
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                  filled: true,
                                  fillColor: AppColors.blurGreen,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16.0 * 1.5, vertical: 16.0),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                              ),
                            ),
                            DropdownButtonFormField(
                              items: signUpCubit.countries,
                              icon: const Icon(Icons.expand_more),
                              //value: signUpCubit.countryId,
                              onChanged: (value)=>signUpCubit.selectCountry(value!),
                              decoration: InputDecoration(
                                hintText: translateLang(context, 'Country'),
                                filled: true,
                                fillColor: AppColors.blurGreen,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0 * 1.5, vertical: 16.0),
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
