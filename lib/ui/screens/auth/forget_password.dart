import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/core/functions/show_toastification.dart';
import 'package:fnrco_candidates/data/api_provider/auth/forget_password.dart';
import 'package:fnrco_candidates/logic/cubit/auth/forget_password/forget_password_cubit.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/auth/name_email_phone_form_field.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/logo.dart';
import 'package:toastification/toastification.dart';

import '../../../constants/app_colors.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ForgetPasswordCubit(forgetPasswordProvider: ForgetPasswordProvider()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is ForgetPasswordSuccessState) {
              //////////// TODO: Verification has been sent to your email

              showToast(context,
                  title: 'verification code',
                  desc: state.code.toString(),
                  type: ToastificationType.info);
              Navigator.of(context)
                  .pushReplacementNamed(AppPagesNames.OTP, arguments: {
                'identifier': context
                    .read<ForgetPasswordCubit>()
                    .forgetPasswordController
                    .text,
                'page': 'forget'
              });
            }
            if (state is ForgetPasswordFailureState) {
              showToast(context,
                  title: 'error',
                  desc: state.message,
                  type: ToastificationType.error);
            }
          },
          builder: (context, state) {
            ForgetPasswordCubit forgetPasswordCubit =
                BlocProvider.of<ForgetPasswordCubit>(context);
            return LogoWithTitle(
              title: 'Forgot Password',
              subText: "Please, enter your e-mail to receive verification code",
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Form(
                        key: forgetPasswordCubit.formKey,
                        child: NameEmailPhoneFormField(
                            controller:
                                forgetPasswordCubit.forgetPasswordController,
                            inputType: TextInputType.emailAddress,
                            prefixIcon: CupertinoIcons.mail,
                            hint: translateLang(context, "email"),
                            validate: forgetPasswordCubit.validateEmail))),
                state is ForgetPasswordLoadingState
                    ? LoadingWidget()
                    : CustomElevatedButton(
                        fun: () {
                          forgetPasswordCubit.verifyEmail(context);
                        },
                        background: AppColors.primary,
                        text: translateLang(context, 'next'))
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
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
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
