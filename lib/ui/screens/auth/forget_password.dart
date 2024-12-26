import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_pages_names.dart';
import '../../../constants/constances.dart';
import '../../../core/functions/show_toast.dart';
import '../../../data/api_provider/auth/forget_password.dart';
import '../../../logic/cubit/auth/forget_password/forget_password_cubit.dart';
import '../../../core/functions/translate.dart';
import '../../widgets/auth/custom_elevated_btn.dart';
import '../../widgets/auth/name_email_phone_form_field.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/logo.dart';
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
            if (state is ForgetPasswordSuccessState) {
              showToast(context,
                  title: translateLang(context, 'success'),
                  desc: translateLang(context, "msg_otp_sent_success"),
                  type: ToastificationType.success);
              Navigator.of(context)
                  .pushReplacementNamed(AppPagesNames.OTP, arguments: {
                IDENTIFIER_KEYWORD: context
                    .read<ForgetPasswordCubit>()
                    .forgetPasswordController
                    .text,
                PAGE_KEYWORD: FORGET_PAGE
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
            if (state is ForgetPasswordFailureState) {
              showToast(context,
                  title: translateLang(context, 'error'),
                  desc: state.message,
                  type: ToastificationType.error);
            }
          },
          builder: (context, state) {
            ForgetPasswordCubit forgetPasswordCubit =
                BlocProvider.of<ForgetPasswordCubit>(context);
            return LogoWithTitle(
              title: translateLang(context, "forgot_password"),
              subText: translateLang(context, "msg_enter_email_rece_opt"),
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
                    ? AnimatedLoadingWidget()
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
                    vertical: 16.0, horizontal: 30.0),
                child: Text(subText,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColors.grey)),
              ),
              ...children,
            ],
          ),
        );
      }),
    );
  }
}
