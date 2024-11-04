import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/core/functions/show_toastification.dart';
import 'package:fnrco_candidates/data/api_provider/auth/otp.dart';
import 'package:fnrco_candidates/logic/cubit/auth/otp/otp_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
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
          const Text("+1 18577 11111"),
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
    print('==========================arguments==============================');
    print(data['identifier']);
    print(data['page']);
    return BlocProvider(
      create: (context) => OtpCubit(OTPProvider())..initiateFocusNode(),
      child: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state is OtpSuccessState) {
            showToast(context,
                title: translateLang(context, 'success'),
                desc: translateLang(context, "msg_otp_verified_success"),
                type: ToastificationType.info);
            if (data['page'] == 'forget') {
              Navigator.of(context).pushReplacementNamed(
                  AppPagesNames.CHANGEPASSWORD,
                  arguments: {'identifier': data['identifier']});
            }
            if (data['page'] == 'signup') {
              Navigator.of(context)
                  .pushReplacementNamed(AppPagesNames.HOMEPAGE);
            }
          }
          if (state is OtpFailureState) {
            showToast(context,
                title: state.message.toString(),
                desc: state.message,
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
                                if (value.length == 1) otpCubit.pin6Node.unfocus();
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
                  ],
                ),
              ),
                if(state is OtpLoadingState)
                Center(child: LoadingWidget(),)
            ],
          
          );
        },
      ),
    );
  }
}

const InputDecoration otpInputDecoration = InputDecoration(
  filled: false,
  border: UnderlineInputBorder(),
  hintText: "0",
);

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
      style: Theme.of(context).textTheme.headlineSmall,
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
                  style: Theme.of(context).textTheme.headlineMedium,
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
