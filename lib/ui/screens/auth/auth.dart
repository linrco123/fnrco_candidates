import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images_path.dart';
import '../../../constants/app_pages_names.dart';
import '../../../core/classes/cache_helper.dart';
import '../../../core/functions/translate.dart';
import '../../../logic/cubit/auth/auth/auth_cubit.dart';
import '../../widgets/auth/custom_elevated_btn.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/logo.dart';

class SigninOrSignupScreen extends StatelessWidget {
  const SigninOrSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthBiometricSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Login done successfully'),
                    backgroundColor: AppColors.success,
                  ));
                  Navigator.of(context).pushNamed(AppPagesNames.HOMEPAGE);
                }
                if (state is AuthBiometricErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.danger,
                  ));
                }
              },
              builder: (context, state) {
                AuthCubit authCubit = BlocProvider.of(context);
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                      //  const Spacer(flex: 2),
                        Expanded(
                          flex: 2,
                          child:   Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:15.0,left: 10.0,right: 10.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.black),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              AppPagesNames.HOMEPAGE,
                                              (route) => false);
                                    },
                                    child: Text(
                                      translateLang(context, "skip"),
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),),
                        const LOGO(),
                        const Spacer(),
                        CustomElevatedButton(
                            fun: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => PollsScreen()));
                              Navigator.of(context)
                                  .pushReplacementNamed(AppPagesNames.LOGIN);
                            },
                            background: AppColors.primary,
                            text: translateLang(context, 'sign_in')),
                        const SizedBox(height: 16.0),
                        CustomElevatedButton(
                            fun: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(AppPagesNames.SIGNUP);
                            },
                            background: AppColors.secondary,
                            text: translateLang(context, 'sign_up')),
                        const SizedBox(height: 16.0),
                        CacheHelper.getBiometricStatus()
                            ? GestureDetector(
                                onTap: () {
                                  authCubit.authWithBiometric();
                                },
                                child: Image.asset(
                                  AppImages.fingerPrint1,
                                  height: 70.0,
                                  width: 70.0,
                                ))
                            // ? CustomElevatedButton(
                            //     fun: () async {
                            //       authCubit.authWithBiometric();
                            //     },
                            //     background: AppColors.secondary,
                            //     text: translateLang(context, "login_biometric"))
                            : const SizedBox(),
                        const Spacer(flex: 2),
                      ],
                    ),
                    if (state is AuthBiometricLoadingState) const LoadingWidget(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
