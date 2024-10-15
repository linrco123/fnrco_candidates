import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/business_logic/cubit/auth/log_in/log_in_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/repositories/auth/log_in.dart';
import 'package:fnrco_candidates/data/web_services/auth/log_in.dart';
import 'package:fnrco_candidates/presentation/widgets/auth/custom_elevated_btn.dart';
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
              create: (context) => LogInCubit(
                  logInRepository:
                      LogInRepository(logInWebServices: LogInWebServices())),
              child: BlocConsumer<LogInCubit, LogInState>(
                  listener: (context, state) {},
                  builder: (BuildContext context, state) {
                    // LogInCubit logInCubit = LogInCubit.instance(context);
                    final LogInCubit logInCubit = BlocProvider.of(context);
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
                                children: [
                                  TextFormField(
                                    controller: logInCubit.phoneController,
                                    validator: (value) => logInCubit
                                        .validatePhone(context, value!),
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(CupertinoIcons.phone),
                                      prefixIconColor: AppColors.grey,
                                      hintText: translateLang(
                                          context, "phone_number"),
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      filled: true,
                                      fillColor: AppColors.blurGreen,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16.0 * 1.5,
                                              vertical: 16.0),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                      ),
                                    ),
                                    keyboardType: TextInputType.phone,
                                    // onSaved: (phone) {
                                    //   // Save it
                                    // },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: TextFormField(
                                      controller: logInCubit.passwordController,
                                      obscureText: logInCubit.obscureText,
                                      validator: (value) => logInCubit
                                          .validatePassword(context, value!),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(CupertinoIcons.lock),
                                        prefixIconColor: AppColors.grey,
                                        suffixIcon: IconButton(
                                            onPressed:
                                                logInCubit.toggleObscureText,
                                            icon: logInCubit.getIcon()),
                                        hintText:
                                            translateLang(context, "password"),
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                        filled: true,
                                        fillColor: AppColors.blurGreen,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16.0 * 1.5,
                                                vertical: 16.0),
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                      ),
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                    ),
                                  ),
                                  CustomElevatedButton(
                                      fun: () {
                                        logInCubit.logIn(context);
                                      },
                                      background: AppColors.primary,
                                      text: translateLang(context, 'sign_in')),
                                  const SizedBox(height: 16.0),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              AppPagesNames.FORGETPASSWORD);
                                    },
                                    child: Text(
                                        translateLang(
                                            context, "forgot_password"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!.copyWith(color: AppColors.greyDeep)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              AppPagesNames.SIGNUP);
                                    },
                                    child: Text.rich(
                                        TextSpan(
                                          text: translateLang(context,
                                              "do_not_have_an_account" ),
                                              style: TextStyle(color: AppColors.greyDeep),
                                          children: [
                                            TextSpan(text: ' '),
                                            TextSpan(
                                              text: translateLang(
                                                  context, "sign_up"),
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
