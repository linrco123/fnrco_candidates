import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/ui/screens/on_boarding/on_boarding2_screen.dart';
import 'package:page_transition/page_transition.dart';

class CustomAnimatedSplashScreen extends StatelessWidget {
  const CustomAnimatedSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Image.asset(AppImages.SPLASH),
        backgroundColor: AppColors.primary,
        nextScreen: const OnboardingScreen(),
        centered: true,
        pageTransitionType:  PageTransitionType.rotate ,
       // nextRoute: AppPagesNames.INITIAL,
        splashIconSize: 250,
        duration: 3000,
        splashTransition: SplashTransition.rotationTransition,
        animationDuration: const Duration(seconds: 2),
    );
  }
}