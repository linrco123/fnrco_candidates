import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import '../../../constants/app_pages_names.dart';
import '../../../constants/constances.dart';
import '../../../core/functions/show_toast.dart';
import '../../../data/api_provider/auth/reset_password.dart';
import '../../../logic/cubit/auth/reset_password/reset_password_cubit.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/translate.dart';
import '../../widgets/auth/custom_elevated_btn.dart';
import '../../widgets/auth/password_form_field.dart';
import '../../widgets/loading_widget.dart';
import 'package:toastification/toastification.dart';

import '../../widgets/logo.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var routedData = ModalRoute.settingsOf(context)!.arguments as Map;
    return BlocProvider(
      create: (context) => ResetPasswordCubit(ResetPasswordprovider()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if (state is ResetPasswordSuccessState) {
              showToast(context,
                  title: translateLang(context, 'success'),
                  desc: translateLang(context, "msg_reset_password"),
                  type: ToastificationType.success);

              Navigator.of(context).pushReplacementNamed(AppPagesNames.SUCCESS,
                  arguments: {PAGE_KEYWORD: FORGET_PAGE});
            }

            if (state is ResetPasswordFailureState) {
              showToast(context,
                  title:
                      translateLang(context, translateLang(context, 'error')),
                  desc: state.message!,
                  type: ToastificationType.error);
            }
          },
          builder: (context, state) {
            //if (state is ResetPasswordLoadingState) {}
            var cubit = ResetPasswordCubit.instance(context);
            return LogoWithTitle(
              title: translateLang(context, "reset_password"),
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
                state is ResetPasswordLoadingState
                    ? const AnimatedLoadingWidget()
                    : CustomElevatedButton(
                        fun: () {
                          logger.e(
                              '===============================eeee=====================');
                          cubit.resetPassword(
                              context, routedData['identifier']);
                        },
                        background: AppColors.primary,
                        text: translateLang(context, 'reset_password')),
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
                style: Theme.of(context).textTheme.headlineLarge,
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
