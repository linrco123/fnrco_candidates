import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/business_logic/cubit/on_boarding/on_boarding_cubit.dart';
import 'package:fnrco_candidates/business_logic/cubit/on_boarding/on_boarding_state.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

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
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Image.network(
                                    item.imageUrl,
                                    
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
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
                                  ]))
                            ],
                          );
                        },
                      ),
                    ),

                    // Current page indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: onBoardingCubit.pages
                          .map((item) => AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                width: onBoardingCubit.currentPage ==
                                        onBoardingCubit.pages.indexOf(item)
                                    ? 30
                                    : 8,
                                height: 8,
                                margin: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0)),
                              ))
                          .toList(),
                    ),

                    // Bottom buttons
                    SizedBox(
                      height: 100,
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
                              onPressed: () {
                                //TODO: onskip 
                                Navigator.of(context)
                                    .pushReplacementNamed(AppPagesNames.AUTH);
                              },
                              child: const Text("Skip")),
                          TextButton(
                            style: TextButton.styleFrom(
                                visualDensity: VisualDensity.comfortable,
                                foregroundColor: Colors.white,
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              if (onBoardingCubit.currentPage ==
                                  onBoardingCubit.pages.length - 1) {
                                //TODO: onFinish
                                 Navigator.of(context)
                                    .pushReplacementNamed(AppPagesNames.AUTH);
                              } else {
                                onBoardingCubit.pageController.animateToPage(
                                    onBoardingCubit.currentPage + 1,
                                    curve: Curves.easeInOutCubic,
                                    duration:
                                        const Duration(milliseconds: 250));
                              }
                            },
                            child: Row(
                              children: [
                                Text(
                                  onBoardingCubit.currentPage ==
                                          onBoardingCubit.pages.length - 1
                                      ? "Finish"
                                      : "Next",
                                ),
                                const SizedBox(width: 8),
                                Icon(onBoardingCubit.currentPage ==
                                        onBoardingCubit.pages.length - 1
                                    ? Icons.done
                                    : Icons.arrow_forward),
                              ],
                            ),
                          ),
                        ],
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
