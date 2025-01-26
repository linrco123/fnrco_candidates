import 'dart:async';

import 'package:flutter/material.dart';
import '../../constants/app_pages_names.dart';
import '../widgets/auth/custom_elevated_btn.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images_path.dart';
import '../../constants/constances.dart';
import '../../core/functions/translate.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatefulWidget {
  final String screenType;

  const SuccessScreen({required this.screenType, super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  int congratTime = 10;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculateCongratTime();
  }

  void calculateCongratTime() {
   final timer =  Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      logger.e('=====================timer.periodic================');
      congratTime--;
      if (congratTime == 0) {
        timer.cancel();
        if (widget.screenType == FORGET_PAGE) {
          Navigator.of(context).pushReplacementNamed(AppPagesNames.AUTH);
        } else {
          Navigator.of(context).pushReplacementNamed(AppPagesNames.HOMEPAGE);
        }
      }
    });
    
  }

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
              // Image.asset(AppImages.SUCCESS2,
              //     width: 250,
              //     height: 250,
              //     fit: BoxFit.cover,
              //    ),
              Lottie.asset(AppImages.SUCCESS3,
                  width: 250,
                  height: 250,
                  backgroundLoading: true,
                  animate: true),
              // Lottie.asset(AppImages.SUCCESS,
              //     width: 250,
              //     height: 250,
              //     backgroundLoading: true,
              //     animate: true),
              const SizedBox(
                height: 0.0,
              ),
              Text(
                translateLang(context, 'congrats'),
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: 30.0),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                translateLang(
                    context,
                    widget.screenType == FORGET_PAGE
                        ? "msg_reset_password"
                        : "account_created_success"),
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: AppColors.grey),
              ),
              const Spacer(),
              widget.screenType == FORGET_PAGE
                  ? CustomElevatedButton(
                      fun: () {
                        Navigator.of(context)
                            .pushReplacementNamed(AppPagesNames.AUTH);
                      },
                      background: AppColors.primary,
                      text: translateLang(context, "back_to_login"))
                  : CustomElevatedButton(
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
