import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  final String screenType;

  const SuccessScreen({required this.screenType, super.key});

  @override
  Widget build(BuildContext context) {
    print('===========screenType=============>>>>>>>>>> $screenType');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
        ),
        body: Container(
          color: AppColors.white,
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
          child: Column(
            children: [
              Lottie.asset(AppImages.SUCCESS,
                  width: 250,
                  height: 250,
                  backgroundLoading: true,
                  animate: true),
              const SizedBox(
                height: 0.0,
              ),
              Text(
                translateLang(context, 'congrats'),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                translateLang(
                    context,
                    screenType == FORGET_PAGE
                        ? "msg_reset_password"
                        : "account_created_success"),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Spacer(),
              screenType == FORGET_PAGE
                        ?
              CustomElevatedButton(
                  fun: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AppPagesNames.AUTH);
                  },
                  background: AppColors.primary,
                  text: translateLang(context, "back_to_login")):CustomElevatedButton(
                  fun: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AppPagesNames.HOMEPAGE);
                  },
                  background: AppColors.primary,
                  text: translateLang(context, "go_to_home")),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ));
  }
}
