import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/logo.dart';
import 'package:local_auth/local_auth.dart';

class SigninOrSignupScreen extends StatelessWidget {
  const SigninOrSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
              const LOGO(),
              const Spacer(),
              CustomElevatedButton(
                  fun: () {
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
                  ? CustomElevatedButton(
                      fun: () async {
                        final LocalAuthentication auth = LocalAuthentication();
                        final bool canAuthenticateWithBiometrics =
                            await auth.canCheckBiometrics;
                        final bool canAuthenticate =
                            canAuthenticateWithBiometrics &&
                                await auth.isDeviceSupported();
                        if(canAuthenticate){
                          try {
                            final bool didAuthenticate = await auth.authenticate(
                                localizedReason: 'Please authenticate to show account balance',
                                options: const AuthenticationOptions(biometricOnly: true));
                          } on PlatformException {
                            // ...
                          }
                        }
                      },
                      background: AppColors.secondary,
                      text: translateLang(context, "login_biometric"))
                  : const SizedBox(),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
