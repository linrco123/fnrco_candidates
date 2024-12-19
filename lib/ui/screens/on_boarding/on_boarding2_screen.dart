import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/logic/cubit/on_boarding/on_boarding_cubit.dart';
import 'package:fnrco_candidates/logic/cubit/on_boarding/on_boarding_state.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/core/localizations/app_localizations.dart';
import 'package:fnrco_candidates/ui/widgets/onboarding/current_page_indictor.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: Scaffold(
        body: BlocBuilder<OnBoardingCubit, OnBoardingState>(
          builder: (context, state) {
            var onBoardingCubit = BlocProvider.of<OnBoardingCubit>(context);
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              color: onBoardingCubit.pages[onBoardingCubit.currentPage].bgColor,
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      // Pageview to render each page
                      child: PageView.builder(
                        controller: onBoardingCubit.pageController,
                        itemCount: onBoardingCubit.pages.length,
                        onPageChanged: (idx) {
                          onBoardingCubit.changeState(idx);
                        },
                        itemBuilder: (context, idx) {
                          final item = onBoardingCubit.pages[idx];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Image.asset(
                                  item.imageUrl,
                                  //height: 200.0,
                                  //width: 200.0,
                                  // fit: BoxFit.fill,
                                ),
                              ),
                              Column(children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(item.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: item.textColor,
                                          )),
                                ),
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 280),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0, vertical: 8.0),
                                  child: Text(item.description,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: item.textColor,
                                          )),
                                )
                              ])
                            ],
                          );
                        },
                      ),
                    ),

                    CurrentPageIndicator(
                        color: AppColors.white,
                        currentPage: onBoardingCubit.currentPage,
                        list: onBoardingCubit.pages,
                        alignment: MainAxisAlignment.center),
                    // Bottom buttons
                    SizedBox(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                style: TextButton.styleFrom(
                                    visualDensity: VisualDensity.comfortable,
                                    foregroundColor: Colors.white,
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () async {
                                  //TODO: onskip
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      AppPagesNames.WELCOME, (route) => false);
                                  await CacheHelper.setOnBoarding();
                                },
                                child: Text(AppLocalizations.of(context)!
                                    .translate('skip'))),
                            TextButton(
                              style: TextButton.styleFrom(
                                  visualDensity: VisualDensity.comfortable,
                                  foregroundColor: Colors.white,
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                onBoardingCubit.moveToNext(context);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    onBoardingCubit.currentPage ==
                                            onBoardingCubit.pages.length - 1
                                        ? AppLocalizations.of(context)!
                                            .translate("finish")
                                        : AppLocalizations.of(context)!
                                            .translate("next"),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    onBoardingCubit.currentPage ==
                                            onBoardingCubit.pages.length - 1
                                        ? Icons.done
                                        : Icons.arrow_forward,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
