import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/business_logic/cubit/auth/log_in/log_in_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/auth/login_provider.dart';
import 'package:fnrco_candidates/presentation/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/presentation/widgets/auth/name_email_phone_form_field.dart';
import 'package:fnrco_candidates/presentation/widgets/auth/password_form_field.dart';
import 'package:fnrco_candidates/presentation/widgets/loading_widget.dart';
import 'package:fnrco_candidates/presentation/widgets/logo.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return BlocProvider(
              create: (context) => LogInCubit(logInProvider: LoginProvider()),
              child: BlocConsumer<LogInCubit, LogInState>(
                  listener: (context, state) {
                if (state is LogInSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Login Successfuly',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: AppColors.white),
                    ),
                    backgroundColor: AppColors.success,
                  ));
                  Navigator.of(context)
                      .pushReplacementNamed(AppPagesNames.HOMEPAGE);
                  // Future.delayed(const Duration(milliseconds: 600))
                  //     .then((value) {

                  // });
                }
                if (state is LogInErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Error while Signing in',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: AppColors.white),
                    ),
                    backgroundColor: AppColors.success,
                  ));
                }
              }, builder: (BuildContext context, state) {
                final LogInCubit logInCubit = LogInCubit.instance(context);
                return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(height: constraints.maxHeight * 0.1),
                        const LOGO(),
                        SizedBox(height: constraints.maxHeight * 0.1),
                        Text(
                          translateLang(context, 'sign_in'),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        Form(
                          key: logInCubit.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              NameEmailPhoneFormField(
                                  controller: logInCubit.emailController,
                                  inputType: TextInputType.emailAddress,
                                  prefixIcon: CupertinoIcons.mail,
                                  hint: translateLang(context, "email"),
                                  validate: logInCubit.validateEmail),
                              Text('hint: candidate@gmail.com' ,textAlign: TextAlign.right, style: TextStyle(color: Colors.grey.shade500),),
                              const SizedBox(
                                height: 16.0,
                              ),
                              PasswordFormField(
                                  controller: logInCubit.passwordController,
                                  obscureText: logInCubit.obscureText,
                                  prefixIcon: CupertinoIcons.lock,
                                  hint: translateLang(context, "password"),
                                  toggleObscureText:
                                      logInCubit.toggleObscureText,
                                  visibleIcon: logInCubit.getIcon(),
                                  validate: logInCubit.validatePassword),
                              Text('hint: password', style: TextStyle(color: Colors.grey.shade500)),
                              const SizedBox(
                                height: 16.0,
                              ),
                              state is LogInLoadingState
                                  ? LoadingWidget()
                                  : CustomElevatedButton(
                                      fun: () {
                                        //Focus to close Keyboard
                                        FocusScope.of(context).unfocus();
                                        logInCubit.logIn();
                                      },
                                      background: AppColors.primary,
                                      text: translateLang(context, 'sign_in')),
                              const SizedBox(height: 16.0),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      AppPagesNames.FORGETPASSWORD);
                                },
                                child: Text(
                                    translateLang(context, "forgot_password"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: AppColors.greyDeep)),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      AppPagesNames.SIGNUP);
                                },
                                child: Text.rich(
                                    TextSpan(
                                      text: translateLang(
                                          context, "do_not_have_an_account"),
                                      style:
                                          TextStyle(color: AppColors.greyDeep),
                                      children: [
                                        TextSpan(text: ' '),
                                        TextSpan(
                                          text:
                                              translateLang(context, "sign_up"),
                                          style: TextStyle(
                                              color: AppColors.primary),
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
                    ));
              }),
            );
          },
        ),
      ),
    );
  }
}
