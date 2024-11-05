import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  final String screenType;

  const SuccessScreen({required this.screenType, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
        ),
        body: Container(
          color: AppColors.white,
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
          child: Column(
            children: [
              // const Icon(
              //   CupertinoIcons.check_mark_circled,
              //   size: 200.0,
              //   color: AppColors.primary,
              // ),
              Lottie.asset(AppImages.SUCCESS,
                  width: 250,
                  height: 250,
                  backgroundLoading: true,
                  animate: true,
                  // controller: AnimationController(
                  //     vsync: Overlay.of(context),
                  //     duration: const Duration(milliseconds: 600))
                      
                      ),
              const SizedBox(
                height: 0.0,
              ),
              Text(
                'congratulations',
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              const SizedBox(
                height: 10.0,
              ),
              Text(
                'Password reset successfully',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Spacer(),
              CustomElevatedButton(
                  fun: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AppPagesNames.AUTH);
                  },
                  background: AppColors.primary,
                  text: 'Back to login')
            ],
          ),
        ));
  }
}
