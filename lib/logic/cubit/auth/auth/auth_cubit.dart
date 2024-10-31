import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
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
          print(
              '================================================================');
          print(' emit(AuthBiometricSuccessState());');
          emit(AuthBiometricSuccessState());
        }
        if (!didAuthenticate) {
          emit(AuthBiometricErrorState(
              message: 'submitted Finger print is not enrolled'));
        }
      } on PlatformException catch (e) {
        if (e.code == auth_error.notAvailable) {
          // Add handling of no hardware here.
          emit(AuthBiometricErrorState(
              message: 'Device doesn\'t support biometric'));
        } else if (e.code == auth_error.notEnrolled) {
          emit(AuthBiometricErrorState(
              message: 'submitted Finger print is not enrolled'));
          // ...
        } else {
          // ...
        }
        // ...
      }
    } else {
      //TODO: Handling Hardware doesn't support biometric
    }
  }
}
