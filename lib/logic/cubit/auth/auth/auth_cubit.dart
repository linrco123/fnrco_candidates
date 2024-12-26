import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import '../../../../core/classes/cache_helper.dart';
import '../../../../data/api_provider/auth/login_provider.dart';
import 'package:meta/meta.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> authWithBiometric() async {
    final LocalAuthentication auth = LocalAuthentication();
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics && await auth.isDeviceSupported();
    if (canAuthenticate) {
      try {
        emit(AuthBiometricLoadingState());
        final bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Please authenticate to have an access onto App',
            options: const AuthenticationOptions(
                biometricOnly: true, stickyAuth: true, useErrorDialogs: true),
            authMessages: const <AuthMessages>[
              AndroidAuthMessages(
                signInTitle: 'Oops! Biometric authentication required!',
                cancelButton: 'No thanks',
              ),
              IOSAuthMessages(
                cancelButton: 'No thanks',
              ),
            ]);
        if (didAuthenticate) {
          var email = CacheHelper.getEmail();
          var password = await CacheHelper.getAPassword();
          LoginProvider()
              .logIn({'email': email, 'password': password}).then((value) {
                  CacheHelper.storeUserData(userLData: value);
                 // CacheHelper.storePassword(passwordController.text);
            emit(AuthBiometricSuccessState());
          }).catchError((error) {
            emit(AuthBiometricErrorState(message: 'Please , try again'));
          });
        }
        if (!didAuthenticate) {
          emit(AuthBiometricErrorState(message: 'Biometric closed suddenly'));
        }
      } on PlatformException catch (e) {
        if (e.code == auth_error.notAvailable) {
          // Add handling of no hardware here.
          emit(AuthBiometricErrorState(
              message: 'Mobile supports not biometric'));
        } else if (e.code == auth_error.notEnrolled) {
          emit(AuthBiometricErrorState(
              message: 'submitted Finger print is not enrolled'));
        } else {
          emit(AuthBiometricErrorState(
              message: 'Unexpected Error ! try again '));
        }
        // ...
      }
    } else {
      //TODO: Handling Hardware doesn't support biometric
    }
  }
}
