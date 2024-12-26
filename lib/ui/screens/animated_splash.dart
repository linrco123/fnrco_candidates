import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images_path.dart';
import '../../core/classes/cache_helper.dart';
import 'on_boarding/on_boarding2_screen.dart';
import 'welcome.dart';
import 'package:page_transition/page_transition.dart';

class CustomAnimatedSplashScreen extends StatelessWidget {
  const CustomAnimatedSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset(AppImages.SPLASH),
      backgroundColor: AppColors.primary,
      nextScreen: CacheHelper.getOnBoarding() == null
          ? const OnboardingScreen()
          : WelcomeScreen(),
      centered: true,
      pageTransitionType: PageTransitionType.leftToRight,

      // nextRoute: AppPagesNames.INITIAL,
      splashIconSize: 250,
      duration: 3000,
      splashTransition: SplashTransition.rotationTransition,
      animationDuration: const Duration(seconds: 2),
    );
  }
}
