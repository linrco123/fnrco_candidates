import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/logic/cubit/on_boarding/on_boarding_state.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
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
      title: 'Job offer 1',
      description: 'Enjoy the best of the world in the palm of your hands.',
      imageUrl:
          'https://img.freepik.com/free-vector/organic-flat-design-join-us-concept_23-2148943565.jpg?t=st=1727793089~exp=1727796689~hmac=ca20b9a4f84c03d7710245344798aaf997d7ffeedf15ca3b4608fe0ef5abaaf0&w=1060',
      bgColor: AppColors.primary,
    ),
    OnboardingPageModel(
      title: 'Job offer 2',
      description: 'Connect with your friends anytime anywhere.',
      imageUrl:
          'https://img.freepik.com/free-vector/organic-flat-join-us-concept_23-2148948357.jpg?uid=R88335988&ga=GA1.1.1515971137.1727185433&semt=ais_hybrid',
      bgColor: const Color(0xff6200ee),
    ),
    OnboardingPageModel(
      title: 'Job offer 3',
      description: 'Bookmark your favourite quotes to read at a leisure time.',
      imageUrl:
          'https://img.freepik.com/free-photo/portrait-cheerful-man-pointing-speech-bubble-with-hiring-ad-making-job-employment-offer-positive-male-recruiter-advertising-hr-work-application-opportunity-with-text-message_482257-40830.jpg?t=st=1727793166~exp=1727796766~hmac=a47e4267fa16b2c783193903eee4e4fe51463e5f2551907b7d2c87673f069fc0&w=2000',
      bgColor: const Color(0xfffeae4f),
    ),
    OnboardingPageModel(
      title: 'Job offer 4',
      description: 'Follow your favourite creators to stay in the loop.',
      imageUrl:
          'https://img.freepik.com/free-vector/flat-join-us-promo-illustrated_23-2148956434.jpg?t=st=1727793180~exp=1727796780~hmac=750698e08e9b4a44a04d31258e6b8c379de16b8e7e7d4792fe8bb512760f4a9d&w=1060',
      bgColor: Colors.purple,
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
