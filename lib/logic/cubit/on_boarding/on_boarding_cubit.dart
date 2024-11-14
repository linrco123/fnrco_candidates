import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/logic/cubit/on_boarding/on_boarding_state.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/data/models/onboarding_model.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitialState());
  static OnBoardingCubit instance(context) => BlocProvider.of(context);
  // Store the currently visible page
  int currentPage = 0;
  // Define a controller for the pageview
  final PageController pageController = PageController(initialPage: 0);
  final List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      title: 'Welcome to FNRCO company',
      description:
          'Congratulations on joining our team! We’re excited to have you on board',
      imageUrl: AppImages.boarding1,
      bgColor: AppColors.primary,//const Color(0xff6200ee),
    ),
    OnboardingPageModel(
      title: 'Meet Your Team',
      description:
          'Your new team is here to support you! Get to know your colleagues and their roles',
      imageUrl: AppImages.boarding2,
      bgColor: AppColors.black,//const Color.fromARGB(255, 0, 83, 238),
    ),
    OnboardingPageModel(
      title: 'Tools for Success',
      description:
          'Here are the tools and resources you’ll need to excel in your new position',
      imageUrl: AppImages.boarding3,
      bgColor: AppColors.primary,//const Color(0xFF2ECC71),
    ),
    OnboardingPageModel(
      title: 'Ready to Get Started?',
      description: 'Let’s take the next step towards your exciting new role!',
      imageUrl: AppImages.boarding4,
      bgColor:AppColors.black,//const Color(0xfffeae4f),
    ),
  ];
  // final VoidCallback? onSkip;
  // final VoidCallback? onFinish;
  void changeState(int page) {
    currentPage = page;
    emit(OnBoardingChangeState());
  }

  void moveToNext(BuildContext context) {
    if (currentPage == pages.length - 1) {
      Navigator.of(context).pushReplacementNamed(AppPagesNames.AUTH);
    } else {
      pageController.animateToPage(currentPage + 1,
          curve: Curves.easeInOutCubic,
          duration: const Duration(milliseconds: 250));
    }
  }
}
