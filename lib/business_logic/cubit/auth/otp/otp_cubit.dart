import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());

  final formKey = GlobalKey<FormState>();
  final List<TextInputFormatter> otpTextInputFormatters = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(1),
  ];
  late FocusNode pin1Node;
  late FocusNode pin2Node;
  late FocusNode pin3Node;
  late FocusNode pin4Node;

  void initiateFocusNode() {
    pin1Node = FocusNode();
    pin2Node = FocusNode();
    pin3Node = FocusNode();
    pin4Node = FocusNode();
  }

  void verifyOtp(String otp, context) {
    emit(OtpLoadingState());
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Navigator.of(context).pushReplacementNamed(AppPagesNames.CHANGEPASSWORD);
      // check your code
    }
  }
}
