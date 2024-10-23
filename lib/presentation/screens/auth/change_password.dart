import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/business_logic/cubit/auth/change_password/change_password_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/presentation/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/presentation/widgets/auth/password_form_field.dart';

import '../../widgets/logo.dart';

class ChangePasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ChangePasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = ChangePasswordCubit.instance(context);
            return LogoWithTitle(
              title: translateLang(context, "change_password"),
              children: [
                Form(
                  key: cubit.formForgetKey,
                  child: Column(
                    children: [
                      PasswordFormField(
                          controller: cubit.PasswordController,
                          obscureText: cubit.obscureText1,
                          prefixIcon: CupertinoIcons.lock,
                          toggleObscureText: cubit.toggleObscureText1,
                          visibleIcon: cubit.getIcon1(),
                          validate: cubit.validatePassword,
                          hint: translateLang(context, 'password')),
                      const SizedBox(
                        height: 16.0,
                      ),
                      PasswordFormField(
                          controller: cubit.ConfirmPasswordController,
                          obscureText: cubit.obscureText2,
                          prefixIcon: CupertinoIcons.lock,
                          toggleObscureText: cubit.toggleObscureText2,
                          visibleIcon: cubit.getIcon2(),
                          validate: cubit.validateConfirmPassword,
                          hint: translateLang(context, 'confirm_password')),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
                CustomElevatedButton(
                    fun: () {
                       cubit.changePassword(context);
                    },
                    background: AppColors.primary,
                    text: translateLang(context, 'change_password')),
              ],
            );
          },
        ),
      ),
    );
  }
}

class LogoWithTitle extends StatelessWidget {
  final String title, subText;
  final List<Widget> children;

  const LogoWithTitle(
      {super.key,
      required this.title,
      this.subText = '',
      required this.children});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: constraints.maxHeight * 0.1),
              const LOGO(),
              SizedBox(
                height: constraints.maxHeight * 0.1,
                width: double.infinity,
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  subText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.5,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.64),
                  ),
                ),
              ),
              ...children,
            ],
          ),
        );
      }),
    );
  }
}
