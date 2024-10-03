import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/business_logic/cubit/auth/sign_up/sign_up_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';

import '../../../constants/app_pages_names.dart';
import '../../widgets/logo.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return BlocBuilder<SignUpCubit, SignUpState>(
              builder: (context, state) {
                final SignUpCubit signUpCubit = BlocProvider.of(context);

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SizedBox(height: constraints.maxHeight * 0.08),
                      const LOGO(),
                      SizedBox(height: constraints.maxHeight * 0.08),
                      Text(
                        "Sign Up",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      Form(
                        key: signUpCubit.formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: signUpCubit.nameController,
                              decoration: const InputDecoration(
                                hintText: 'Full name',
                                filled: true,
                                fillColor: Color(0xFFF5FCF9),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0 * 1.5, vertical: 16.0),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                              ),
                              onSaved: (name) {
                                // Save it
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: signUpCubit.phoneController,
                              decoration: const InputDecoration(
                                hintText: 'Phone',
                                filled: true,
                                fillColor: Color(0xFFF5FCF9),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0 * 1.5, vertical: 16.0),
                                border: OutlineInputBorder(
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
                                controller: signUpCubit.passwordController,
                                decoration: const InputDecoration(
                                  hintText: 'Password',
                                  filled: true,
                                  fillColor: Color(0xFFF5FCF9),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.0 * 1.5, vertical: 16.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                ),
                                obscureText: true,
                                onSaved: (passaword) {
                                  // Save it
                                },
                              ),
                            ),
                            DropdownButtonFormField(
                              items: signUpCubit.countries,
                              icon: const Icon(Icons.expand_more),
                              onSaved: (country) {
                                // save it
                              },
                              onChanged: (value) {},
                              decoration: const InputDecoration(
                                hintText: 'Country',
                                filled: true,
                                fillColor: Color(0xFFF5FCF9),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0 * 1.5, vertical: 16.0),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 48),
                                  shape: const StadiumBorder(),
                                ),
                                child: const Text("Sign Up"),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(AppPagesNames.LOGIN);
                              },
                              child: Text.rich(
                                 TextSpan(
                                  text: "Already have an account? ",
                                  children: [
                                    TextSpan(
                                      text: "Sign in",
                                      style:
                                          TextStyle(color:AppColors.primary),
                                    ),
                                  ],
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color!
                                          .withOpacity(0.64),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
