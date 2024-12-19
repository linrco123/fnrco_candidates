import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/data/api_provider/auth/forget_password.dart';
import 'package:fnrco_candidates/data/api_provider/auth/otp_provider.dart';
import 'package:fnrco_candidates/logic/cubit/auth/forget_password/forget_password_cubit.dart';
import 'package:fnrco_candidates/logic/cubit/auth/otp/otp_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';
import '../../widgets/logo.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: LogoWithTitle(
        title: translateLang(context, "verification_code"),
        subText: translateLang(context, "enter_the_code_sent_to"),
        children: [
          Text(
            "+1 18577 11111",
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: AppColors.grey),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          // OTP Form
          const OtpForm(),
        ],
      ),
    );
  }
}

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.settingsOf(context)!.arguments as Map;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => OtpCubit(OTPProvider())..initiateFocusNode()),
        BlocProvider(
            create: (context) => ForgetPasswordCubit(
                forgetPasswordProvider: ForgetPasswordProvider()))
      ],
      child: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state is OtpSuccessState) {
            showToast(context,
                title: translateLang(context, 'success'),
                desc: translateLang(context, "msg_otp_verified_success"),
                type: ToastificationType.success);
            if (data[PAGE_KEYWORD] == FORGET_PAGE) {
              Navigator.of(context).pushReplacementNamed(
                  AppPagesNames.RESETPASSWORD,
                  arguments: {'identifier': data['identifier']});
            }
            if (data[PAGE_KEYWORD] == SIGNUP_PAGE) {
              Navigator.of(context).pushReplacementNamed(AppPagesNames.SUCCESS,
                  arguments: {PAGE_KEYWORD: SIGNUP_PAGE});
            }
          }
          if (state is OtpFailureState) {
            showToast(context,
                title: 'error',
                desc: state.message,
                type: ToastificationType.error);
          }

          ////////////////////TODO: Resend verification code again ////////////
          if (state is OTPResendVerificationCodeSuccessState) {
            showToast(context,
                title: translateLang(context, 'success'),
                desc: translateLang(context, "msg_otp_sent_success"),
                type: ToastificationType.success);

            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      content: Text(
                        'code: ${state.code}',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ));
          }
          if (state is OTPResendVerificationCodeFailureState) {
            showToast(context,
                title: translateLang(context, 'error'),
                desc: state.message!,
                type: ToastificationType.error);
          }
        },
        builder: (context, state) {
          final OtpCubit otpCubit = BlocProvider.of(context);
          return Stack(
            children: [
              Form(
                key: otpCubit.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: OtpTextFormField(
                              controller: otpCubit.pin1NodeController,
                              focusNode: otpCubit.pin1Node,
                              onChanged: (value) {
                                if (value.length == 1)
                                  otpCubit.pin2Node.requestFocus();
                              },
                              onSaved: (pin) {
                                // Save it
                              },
                              autofocus: true,
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: OtpTextFormField(
                              controller: otpCubit.pin2NodeController,
                              focusNode: otpCubit.pin2Node,
                              onChanged: (value) {
                                if (value.length == 1)
                                  otpCubit.pin3Node.requestFocus();
                              },
                              onSaved: (pin) {
                                // Save it
                              },
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: OtpTextFormField(
                              controller: otpCubit.pin3NodeController,
                              focusNode: otpCubit.pin3Node,
                              onChanged: (value) {
                                if (value.length == 1)
                                  otpCubit.pin4Node.requestFocus();
                              },
                              onSaved: (pin) {
                                // Save it
                              },
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: OtpTextFormField(
                              controller: otpCubit.pin4NodeController,
                              focusNode: otpCubit.pin4Node,
                              onChanged: (value) {
                                if (value.length == 1)
                                  otpCubit.pin5Node.requestFocus();
                              },
                              onSaved: (pin) {
                                // Save it
                              },
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: OtpTextFormField(
                              controller: otpCubit.pin5NodeController,
                              focusNode: otpCubit.pin5Node,
                              onChanged: (value) {
                                if (value.length == 1)
                                  otpCubit.pin6Node.requestFocus();
                              },
                              onSaved: (pin) {
                                // Save it
                              },
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: OtpTextFormField(
                              controller: otpCubit.pin6NodeController,
                              focusNode: otpCubit.pin6Node,
                              onChanged: (value) {
                                if (value.length == 1)
                                  otpCubit.pin6Node.unfocus();
                              },
                              onSaved: (pin) {
                                // Save it
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    CustomElevatedButton(
                        fun: () {
                          otpCubit.verifyOtp(context);
                        },
                        background: AppColors.primary,
                        text: translateLang(context, 'next')),
                    const SizedBox(height: 20.0),
                    TextButton(
                      onPressed: () {
                        otpCubit.resendVerifyCode(
                            context, data[IDENTIFIER_KEYWORD]);
                      },
                      child: Text.rich(
                          TextSpan(
                            text: translateLang(
                                context, "did_not_receive_the_code"),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: AppColors.grey),
                            children: [
                              TextSpan(text: ' '),
                              TextSpan(
                                text: translateLang(context, "resend_code"),
                                style: TextStyle(color: AppColors.primary),
                              ),
                            ],
                          ),
                          style: Theme.of(context).textTheme.headlineSmall),
                    ),
                  ],
                ),
              ),
              if (state is OtpLoadingState ||
                  state is OTPResendVerificationCodeLoadingState)
                Center(
                  child: Lottie.asset(AppImages.LOADING,
                      height: 300.0,
                      width: 300.0,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter),
                ),
              // AnimatedLoadingWidget(height: 150.0,width: 150,)
            ],
          );
        },
      ),
    );
  }
}

InputDecoration otpInputDecoration = InputDecoration(
    filled: false,
    border: UnderlineInputBorder(),
    hintText: "0",
    hintStyle: TextStyle(color: AppColors.grey, fontSize: 18.0));

class OtpTextFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final bool autofocus;
  final TextEditingController controller;

  const OtpTextFormField(
      {super.key,
      this.focusNode,
      this.onChanged,
      this.onSaved,
      this.autofocus = false,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      focusNode: focusNode,
      onChanged: onChanged,
      onSaved: onSaved,
      autofocus: autofocus,
      obscureText: true,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(1),
      ],
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: Theme.of(context)
          .textTheme
          .labelMedium!
          .copyWith(color: AppColors.grey),
      decoration: otpInputDecoration,
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
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColors.grey, fontWeight: FontWeight.w500),
                  // style: TextStyle(
                  //   height: 1.5,
                  //   color: Theme.of(context)
                  //       .textTheme
                  //       .bodyLarge!
                  //       .color!
                  //       .withOpacity(0.64),
                  // ),
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
