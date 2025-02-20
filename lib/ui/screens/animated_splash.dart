import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images_path.dart';
import '../../core/classes/cache_helper.dart';
import 'on_boarding/on_boarding2_screen.dart';
import 'welcome.dart';
import 'package:page_transition/page_transition.dart';

class CustomAnimatedSplashScreen extends StatefulWidget {
  const CustomAnimatedSplashScreen({Key? key}) : super(key: key);

  @override
  State<CustomAnimatedSplashScreen> createState() => _CustomAnimatedSplashScreenState();
}

class _CustomAnimatedSplashScreenState extends State<CustomAnimatedSplashScreen> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_){
      
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset(AppImages.SPLASH),
      backgroundColor: AppColors.primary,
      nextScreen: nextScreen(),
      centered: true,
      pageTransitionType: PageTransitionType.leftToRight,

      // nextRoute: AppPagesNames.INITIAL,
      splashIconSize: 250,
      duration: 3000,
      splashTransition: SplashTransition.rotationTransition,
      animationDuration: const Duration(seconds: 2),
    );
  }

  Widget nextScreen() {
    return CacheHelper.getOnBoarding() == null
        ? const OnboardingScreen()
        : const WelcomeScreen();
  }

  void checkInternet(){
    
  }
}
