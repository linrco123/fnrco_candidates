import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/business_logic/cubit/auth/log_in/log_in_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/data/repositories/auth/log_in.dart';
import 'package:fnrco_candidates/data/web_services/auth/log_in.dart';
import 'package:fnrco_candidates/presentation/widgets/logo.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return BlocProvider(
              create: (context) => LogInCubit(
                  logInRepository:
                      LogInRepository(logInWebServices: LogInWebServices())),
              child: BlocBuilder<LogInCubit, LogInState>(
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
                          "Sign In",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        Form(
                          key: logInCubit.formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: logInCubit.phoneController,
                                decoration: InputDecoration(
                                  hintText: 'Phone',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                  filled: true,
                                  fillColor: AppColors.blurGreen,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16.0 * 1.5, vertical: 16.0),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                ),
                                keyboardType: TextInputType.phone,
                                onSaved: (phone) {
                                  // Save it
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: TextFormField(
                                  controller: logInCubit.passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                    filled: true,
                                    fillColor: AppColors.blurGreen,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16.0 * 1.5, vertical: 16.0),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  logInCubit.logIn(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 48),
                                  shape: const StadiumBorder(),
                                ),
                                child: const Text("Sign in"),
                              ),
                              const SizedBox(height: 16.0),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      AppPagesNames.FORGETPASSWORD);
                                },
                                child: Text('Forgot Password?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      AppPagesNames.SIGNUP);
                                },
                                child: Text.rich(
                                    TextSpan(
                                      text: "Don’t have an account? ",
                                      children: [
                                        TextSpan(
                                          text: "Sign Up",
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
