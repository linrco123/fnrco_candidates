part of 'otp_cubit.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}

final class OtpLoadingState extends OtpState {}

final class OtpSuccessState extends OtpState {}

final class OtpFailureState extends OtpState {
  final String message;

  OtpFailureState({required this.message});
}

final class OTPResendVerificationCodeLoadingState extends OtpState{}

final class OTPResendVerificationCodeSuccessState extends OtpState {
  final int? code ;

  OTPResendVerificationCodeSuccessState({this.code});
}

final class OTPResendVerificationCodeFailureState extends OtpState {
  final String? message;

  OTPResendVerificationCodeFailureState({ this.message});
}
