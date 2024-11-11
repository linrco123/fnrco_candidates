import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/logic/bloc/internet/internet_bloc.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';

class InternetConnectionScreen extends StatelessWidget {
  const InternetConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            leading: const SizedBox(),
            backgroundColor: AppColors.primary.withOpacity(0.1),
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark),
          ),
          body: BlocConsumer<InternetBloc, InternetState>(
            listener: (context, state) {
              if (state is InternetConnected) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${state.internetStatus.toString()}'),
                  backgroundColor: AppColors.success,
                ));
              }
              if (state is InternetDisConnected) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('internet disconnected'),
                  backgroundColor: AppColors.danger,
                ));
              }
            },
            builder: (context, state) {
              return Container(
                height: double.infinity,
                width: double.infinity,
                color: AppColors.primary.withOpacity(0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.wifi1,
                      height: 100.0,
                      width: 100.0,
                      color: AppColors.primary,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      translateLang(context, 'no_internet_conn'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: AppColors.grey),
                    ),
                    Text(
                      translateLang(context, 'steps_back_conn'),
                      style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: AppColors.grey),
                    ),
                    
                     const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.check_mark_circled_solid,
                          size: 20.0,
                          color: AppColors.black.withOpacity(0.6),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          translateLang(context, "check_modem"),
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: AppColors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.check_mark_circled_solid,
                          size: 20.0,
                          color: AppColors.black.withOpacity(0.6),
                        ),
                        const SizedBox(
                          width: 10.0,
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
                    const SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      width: 150.0,
                      height: 50.0,
                      child: CustomElevatedButton(
                          fun: ()async {
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
