import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/auth/custom_elevated_btn.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images_path.dart';
import '../../constants/enums.dart';
import '../../core/functions/show_snackbar.dart';
import '../../core/functions/translate.dart';
import '../../logic/bloc/internet/internet_bloc.dart';

class InternetConnectionScreen extends StatelessWidget {
  const InternetConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          backgroundColor: AppColors.white,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark),
        ),
        body: BlocConsumer<InternetBloc, InternetState>(
          listener: (context, state) {
            if (state is InternetConnected) {
              showGeneralSnackBar(context,
                  widget: Row(
                    children: [
                      const SizedBox(
                        width: 20.0,
                      ),
                      Image.asset(
                        AppImages.wifi_on,
                        height: 30.0,
                        width: 30.0,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        '${translateLang(context, "msg_internet_back")} ${state.internetStatus == InternetStatus.Mobile ? 'Mobile' : 'Wifi'}!',
                        style: TextStyle(color: AppColors.white),
                      )
                    ],
                  ));
            } else if (state is InternetDisConnected) {
              showGeneralSnackBar(context,
                  widget: Row(
                    children: [
                      const SizedBox(
                        width: 20.0,
                      ),
                      Image.asset(
                        AppImages.wifi_off,
                        height: 30.0,
                        width: 30.0,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        translateLang(context, "msg_internet_off"),
                        style: TextStyle(color: AppColors.white),
                      )
                    ],
                  ));
            }
          },
          builder: (context, state) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              //color: AppColors.primary.withOpacity(0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   translateLang(context, 'no_internet_conn'),
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 18.0,
                  //       color: AppColors.grey),
                  // ),
                  // const SizedBox(
                  //   height: 0.0,
                  // ),
                  // Lottie.asset(AppImages.SERVER_FAILURE,
                  //     height: 400.0, width: 400.0, fit: BoxFit.cover),
                  // Image.asset(
                  //   AppImages.wifi1,
                  //   height: 100.0,
                  //   width: 100.0,
                  //   color: AppColors.primary,
                  // ),
                  Image.asset(
                    'assets/images/wifi1.png',
                    height: 150.0,
                    width: 150.0,
                    color: AppColors.primary,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    translateLang(context, 'no_internet_conn'),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: AppColors.grey),
                  ),
                  Text(
                    translateLang(context, 'steps_back_conn'),
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: AppColors.grey),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Icon(
                            CupertinoIcons.check_mark_circled_solid,
                            size: 20.0,
                            color: AppColors.black.withOpacity(0.6),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Icon(
                            CupertinoIcons.check_mark_circled_solid,
                            size: 20.0,
                            color: AppColors.black.withOpacity(0.6),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            translateLang(context, "check_modem"),
                            style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: AppColors.grey),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            translateLang(context, "check_wifi"),
                            style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: AppColors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    width: 150.0,
                    height: 50.0,
                    child: CustomElevatedButton(
                        fun: () async {
                          await context.read<InternetBloc>().checkConnec();
                        },
                        background: AppColors.primary,
                        text: translateLang(context, 'reload')),
                  )
                ],
              ),
            );
          },
        ));
  }
}
