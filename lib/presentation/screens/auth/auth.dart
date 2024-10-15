import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/presentation/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/presentation/widgets/logo.dart';

class SigninOrSignupScreen extends StatelessWidget {
  const SigninOrSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
              const LOGO(),
              const Spacer(),

              CustomElevatedButton(
                  fun: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AppPagesNames.LOGIN);
                  },
                  background: AppColors.primary,
                  text: "Sign In"),
              const SizedBox(height: 16.0),
              CustomElevatedButton(
                  fun: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AppPagesNames.SIGNUP);
                  },
                  background: AppColors.secondary,
                  text: "Sign Up"),
              
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
