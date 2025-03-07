import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_images_path.dart';
import '../../../core/functions/show_toast.dart';
import '../../../logic/cubit/auth/log_in/log_in_cubit.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_pages_names.dart';
import '../../../core/functions/translate.dart';
import '../../../data/api_provider/auth/login_provider.dart';
import '../../widgets/auth/custom_elevated_btn.dart';
import '../../widgets/auth/custom_socialMedia_btn.dart';
import '../../widgets/auth/name_email_phone_form_field.dart';
import '../../widgets/auth/password_form_field.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/logo.dart';
import 'package:toastification/toastification.dart';

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
                  Navigator.of(context)
                      .pushReplacementNamed(AppPagesNames.HOMEPAGE);
                  showToast(context,
                      title: translateLang(context, 'success'),
                      desc: translateLang(context, "msg_login_success"),
                      type: ToastificationType.success);
                }
                if (state is LogInErrorState) {
                  showToast(context,
                      title: translateLang(context, 'error'),
                      desc: state.message,
                      type: ToastificationType.error);

                  // showErrorSnackBar(context, text: state.message);
                }
              }, builder: (BuildContext context, state) {
                final LogInCubit logInCubit = LogInCubit.instance(context);
                return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(height: constraints.maxHeight * 0.1),
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
                          translateLang(context, 'sign_in'),
                          style: Theme.of(context).textTheme.headlineLarge!,
                        ),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        Form(
                          key: logInCubit.formKey,
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              NameEmailPhoneFormField(
                                  controller: logInCubit.emailController,
                                  inputType: TextInputType.emailAddress,
                                  prefixIcon: CupertinoIcons.mail,
                                  hint: translateLang(context, "email"),
                                  validate: logInCubit.validateEmail),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              //     const SizedBox(
                              //       width: 15.0,
                              //     ),
                              //     Text(
                              //       'hint: candidate@gmail.com',
                              //       textAlign: TextAlign.right,
                              //       style:
                              //           TextStyle(color: Colors.grey.shade500),
                              //     ),
                              //   ],
                              // ),
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
                              // Row(
                              //   children: [
                              //     const SizedBox(
                              //       width: 15.0,
                              //     ),
                              //     Text('hint: password',
                              //         style: TextStyle(
                              //             color: Colors.grey.shade500)),
                              //   ],
                              // ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              state is LogInLoadingState
                                  ? const AnimatedLoadingWidget()
                                  : CustomElevatedButton(
                                      fun: () {
                                        //Focus to close Keyboard
                                        FocusScope.of(context).unfocus();
                                        logInCubit.logIn();
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             WelcomeScreen()));
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
                                        .labelMedium!
                                        .copyWith(color: AppColors.grey)),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(color: AppColors.grey),
                                      children: [
                                        const TextSpan(text: ' '),
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
                              const SizedBox(
                                height: 30.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SocialMediaButton(
                                    dimension: 50.0,
                                    image: AppImages.facebook,
                                    onPressed: () {
                                      logInCubit.signInWithFacebook();
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  SocialMediaButton(
                                    dimension: 50.0,
                                    image: AppImages.google,
                                    onPressed: () {
                                      logInCubit.signInWithGoogle();
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  SocialMediaButton(
                                    dimension: 50.0,
                                    image: AppImages.linkedIn,
                                    onPressed: () {},
                                  ),
                                ],
                              )
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
