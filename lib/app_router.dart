import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/ui/screens/auth/auth.dart';
import 'package:fnrco_candidates/ui/screens/auth/change_password.dart';
import 'package:fnrco_candidates/ui/screens/auth/forget_password.dart';
import 'package:fnrco_candidates/ui/screens/auth/log_in.dart';
import 'package:fnrco_candidates/ui/screens/home_page/home_page.dart';
import 'package:fnrco_candidates/ui/screens/internet_connection.dart';
import 'package:fnrco_candidates/ui/screens/job_application.dart';
import 'package:fnrco_candidates/ui/screens/job_details.dart';
import 'package:fnrco_candidates/ui/screens/job_offer.dart';
import 'package:fnrco_candidates/ui/screens/medical_declare.dart';
import 'package:fnrco_candidates/ui/screens/on_boarding/on_boarding2_screen.dart';
import 'package:fnrco_candidates/ui/screens/auth/otp.dart';
import 'package:fnrco_candidates/ui/screens/auth/sign_up.dart';
import 'package:fnrco_candidates/ui/screens/profile.dart';
import 'package:fnrco_candidates/ui/screens/profile_editing.dart';
import 'package:fnrco_candidates/ui/screens/resume.dart';

class AppRouter {
  static Route? routeTo(RouteSettings settings) {
    switch (settings.name) {
      case AppPagesNames.INITIAL:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      case AppPagesNames.AUTH:
        return MaterialPageRoute(
            builder: (context) => const SigninOrSignupScreen());
      case AppPagesNames.LOGIN:
        return MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        );
      case AppPagesNames.SIGNUP:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
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
          builder: (context) => ForgotPassword(),
        );
      case AppPagesNames.HOMEPAGE:
        return MaterialPageRoute(
          builder: (context) => const HomePageScreen(),
        );
      case AppPagesNames.PROFILE:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        );
      case AppPagesNames.PROFILE_EDITING:
        return MaterialPageRoute(
          builder: (context) => const EditProfileScreen(),
        );
      case AppPagesNames.RESUME:
        return MaterialPageRoute(
          builder: (context) => ResumeScreen(),
        );
      case AppPagesNames.HEALTH_CARE:
        return MaterialPageRoute(
          builder: (context) => MedicalDeclaration(),
        );
      case AppPagesNames.JOB_OFFER:
        return MaterialPageRoute(
          builder: (context) => JobOfferScreen(
            pdfLink: '',
          ),
        );
      case AppPagesNames.INTERNET_CONNECTION:
        return MaterialPageRoute(
          builder: (context) => InternetConnectionScreen(),
        );
      case AppPagesNames.JOB_DETAILS:
        var args = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => JobDetailsScreen(),
            settings: RouteSettings(arguments: args));

      case AppPagesNames.JOB_APPLICATION:
        var jobID = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => JobApplicationScreen(),
            settings: RouteSettings(arguments: jobID));

      //JobApplicationScreen
    }

    return null;
  }
}
