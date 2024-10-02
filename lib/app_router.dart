import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/presentation/screens/auth/auth.dart';
import 'package:fnrco_candidates/presentation/screens/auth/change_password.dart';
import 'package:fnrco_candidates/presentation/screens/auth/forget_password.dart';
import 'package:fnrco_candidates/presentation/screens/auth/log_in.dart';
import 'package:fnrco_candidates/presentation/screens/home_page/home_page.dart';
import 'package:fnrco_candidates/presentation/screens/on_boarding/on_boarding2_screen.dart';
import 'package:fnrco_candidates/presentation/screens/auth/otp.dart';
import 'package:fnrco_candidates/presentation/screens/auth/sign_up.dart';

class AppRouter {
  static Route? routeTo(RouteSettings route) {
    switch (route.name) {
      case AppPagesNames.INITIAL:
        return MaterialPageRoute(
          builder: (context) => const OnboardingPage(),
        );
      case AppPagesNames.AUTH:
        return MaterialPageRoute(
            builder: (context) => const SigninOrSignupScreen());
      case AppPagesNames.LOGIN:
        return MaterialPageRoute(
          builder: (context) => SignInScreen(),
        );
      case AppPagesNames.SIGNUP:
        return MaterialPageRoute(
          builder: (context) => SignUpScreen(),
        );
      case AppPagesNames.OTP:
        return MaterialPageRoute(
          builder: (context) => const VerificationScreen(),
        );
      case AppPagesNames.CHANGEPASSWORD:
        return MaterialPageRoute(
          builder: (context) => ChangePasswordScreen(),
        );
      case AppPagesNames.FORGETPASSWORD:
        return MaterialPageRoute(
          builder: (context) => const ForgotPassword(),
        );
        case AppPagesNames.HOMEPAGE:
        return MaterialPageRoute(
          builder: (context) => HomePageScreen(),
        );
    }
    return null;
  }
}
