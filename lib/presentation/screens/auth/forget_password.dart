import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/logic/cubit/auth/forget_password/forget_password_cubit.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/presentation/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/presentation/widgets/auth/name_email_phone_form_field.dart';
import 'package:fnrco_candidates/presentation/widgets/logo.dart';

import '../../../constants/app_colors.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            ForgetPasswordCubit forgetPasswordCubit =
                BlocProvider.of<ForgetPasswordCubit>(context);
            return LogoWithTitle(
              title: 'Forgot Password',
              subText:
                  "Integer quis dictum tellus, a auctorlorem. Cras in biandit leo suspendiss.",
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Form(
                    key: forgetPasswordCubit.formKey,
                    child: NameEmailPhoneFormField(
                        controller:
                            forgetPasswordCubit.forgetPasswordController,
                        inputType: TextInputType.phone,
                        prefixIcon: CupertinoIcons.phone,
                        hint: translateLang(context, "phone_number"),
                        validate: forgetPasswordCubit.validatePhone),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 16.0),
                //   child: Form(
                //     key: forgetPasswordCubit.formKey,
                //     child: TextFormField(
                //       controller: forgetPasswordCubit.forgetPasswordController,
                //       validator: (value) =>
                //           forgetPasswordCubit.validatePhone(context, value!),
                //       decoration: InputDecoration(
                //         prefixIcon: Icon(CupertinoIcons.phone),
                //         prefixIconColor: AppColors.grey,
                //         hintText: translateLang(context, "phone_number"),
                //         hintStyle: Theme.of(context).textTheme.headlineMedium,
                //         filled: true,
                //         fillColor: AppColors.blurGreen,
                //         contentPadding: const EdgeInsets.symmetric(
                //             horizontal: 16.0 * 1.5, vertical: 16.0),
                //         border: const OutlineInputBorder(
                //           borderSide: BorderSide.none,
                //           borderRadius: BorderRadius.all(Radius.circular(50)),
                //         ),
                //       ),
                //       keyboardType: TextInputType.phone,
                //     ),
                //   ),
                // ),
                CustomElevatedButton(
                    fun: () {
                      forgetPasswordCubit.verifyPhone(context);
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
