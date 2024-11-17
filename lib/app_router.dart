import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/ui/screens/animated_splash.dart';
import 'package:fnrco_candidates/ui/screens/auth/auth.dart';
import 'package:fnrco_candidates/ui/screens/auth/reset_password.dart';
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
import 'package:fnrco_candidates/ui/screens/success.dart';
import 'package:fnrco_candidates/ui/screens/welcome.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  static Route? routeTo(RouteSettings settings) {
    switch (settings.name) {
      case AppPagesNames.INITIAL:
        // return MaterialPageRoute(
        //   builder: (context) => const OnboardingScreen(),
        // );
        return PageTransition(
            child: const OnboardingScreen(),
            type: PageTransitionType.rotate,
            alignment: Alignment.centerLeft,
            duration: const Duration(seconds: 1));
            case AppPagesNames.WELCOME:
              // return MaterialPageRoute(
        //   builder: (context) => const WelcomeScreen(),
        // );
        return PageTransition(
            child: const WelcomeScreen(),
            type: PageTransitionType.rotate,
            alignment: Alignment.centerLeft,
            duration: const Duration(seconds: 1));
      case AppPagesNames.AUTH:
        return PageTransition(
            child: const SigninOrSignupScreen(),
            type: PageTransitionType.rotate,
            alignment: Alignment.centerLeft,
            duration: const Duration(seconds: 1));
      // return MaterialPageRoute(
      //     builder: (context) => const SigninOrSignupScreen());
      case AppPagesNames.LOGIN:
        // return MaterialPageRoute(
        //   builder: (context) => const SignInScreen(),
        // );
        return PageTransition(
            child: const SignInScreen(),
            type: PageTransitionType.rotate,
            alignment: Alignment.centerLeft,
            duration: const Duration(seconds: 1));
      case AppPagesNames.SIGNUP:
        // return MaterialPageRoute(
        //   builder: (context) => const SignUpScreen(),
        // );
        return PageTransition(
          child: const SignUpScreen(),
          type: PageTransitionType.rotate,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.OTP:
        var identifier = (settings.arguments as Map)['identifier'];
        var page = (settings.arguments as Map)['page'];

        // return MaterialPageRoute(
        //     builder: (context) => const VerificationScreen(),
        //     settings: RouteSettings(
        //         arguments: {'identifier': identifier, 'page': page}));

        return PageTransition(
            child: const VerificationScreen(),
            type: PageTransitionType.rotate,
            alignment: Alignment.centerLeft,
            duration: const Duration(seconds: 1),
            settings: RouteSettings(
                arguments: {'identifier': identifier, 'page': page}));

      case AppPagesNames.RESETPASSWORD:
        var identifier = (settings.arguments as Map)['identifier'];
        // return MaterialPageRoute(
        //     builder: (context) => ChangePasswordScreen(),
        //     settings: RouteSettings(arguments: {'identifier': identifier}));

        return PageTransition(
            child: ChangePasswordScreen(),
            type: PageTransitionType.rotate,
            alignment: Alignment.centerLeft,
            duration: const Duration(seconds: 1),
            settings: RouteSettings(arguments: {'identifier': identifier}));

      case AppPagesNames.FORGETPASSWORD:
        // return MaterialPageRoute(
        //   builder: (context) => ForgotPassword(),
        // );
        return PageTransition(
          child: ForgotPassword(),
          type: PageTransitionType.rotate,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.HOMEPAGE:
        // return MaterialPageRoute(
        //   builder: (context) => const HomePageScreen(),
        // );
        return PageTransition(
          child: HomePageScreen(),
          type: PageTransitionType.rotate,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.PROFILE:
        // return MaterialPageRoute(
        //   builder: (context) => const ProfileScreen(),
        // );
        return PageTransition(
          child: ProfileScreen(),
          type: PageTransitionType.rotate,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.PROFILE_EDITING:
        // return MaterialPageRoute(
        //   builder: (context) => const EditProfileScreen(),
        // );
        return PageTransition(
          child: EditProfileScreen(),
          type: PageTransitionType.rotate,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.RESUME:
        // return MaterialPageRoute(
        //   builder: (context) => ResumeScreen(),
        // );
        return PageTransition(
          child: ResumeScreen(),
          type: PageTransitionType.rotate,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.SUCCESS:
        // return MaterialPageRoute(
        //   builder: (context) => SuccessScreen(
        //     screenType: (settings.arguments as Map)[PAGE_KEYWORD],
        //   ),
        // );
        return PageTransition(
          child: SuccessScreen(
            screenType: (settings.arguments as Map)[PAGE_KEYWORD],
          ),
          type: PageTransitionType.rotate,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.HEALTH_CARE:
        // return MaterialPageRoute(
        //   builder: (context) => MedicalDeclaration(),
        // );
        return PageTransition(
          child: MedicalDeclaration(),
          type: PageTransitionType.rotate,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.JOB_OFFER:
        // return MaterialPageRoute(
        //   builder: (context) => JobOfferScreen(
        //     pdfLink: '',
        //   ),
        // );
        return PageTransition(
          child: JobOfferScreen(
            pdfLink: '',
          ),
          type: PageTransitionType.rotate,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.INTERNET_CONNECTION:
        //   return MaterialPageRoute(
        //     builder: (context) => InternetConnectionScreen(),
        //   );
        return PageTransition(
          child: InternetConnectionScreen(),
          type: PageTransitionType.rotate,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      case AppPagesNames.JOB_DETAILS:
        // return MaterialPageRoute(
        //   builder: (context) => JobDetailsScreen(),
        // );
        return PageTransition(
          child: JobDetailsScreen(),
          type: PageTransitionType.rotate,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );

      case AppPagesNames.ANIMATED_SPLASH:
        // return MaterialPageRoute(
        //   builder: (context) => CustomAnimatedSplashScreen(),
        // );
        return PageTransition(
            child: const CustomAnimatedSplashScreen(),
            type: PageTransitionType.rotate,
            alignment: Alignment.centerLeft,
            duration: const Duration(seconds: 1));
      case AppPagesNames.JOB_APPLICATION:
        // return MaterialPageRoute(
        //     builder: (context) => JobApplicationScreen(),
        //     );
        return PageTransition(
          child: JobApplicationScreen(),
          type: PageTransitionType.rotate,
          alignment: Alignment.centerLeft,
          duration: const Duration(seconds: 1),
        );
      //JobApplicationScreen
    }

    return null;
  }
}
