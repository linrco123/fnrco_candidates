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
  late final pin1NodeController;
  late final pin2NodeController;
  late final pin3NodeController;
  late final pin4NodeController;
  late FocusNode pin1Node;
  late FocusNode pin2Node;
  late FocusNode pin3Node;
  late FocusNode pin4Node;

  void initiateFocusNode() {
    ////////////// TODO : init FocusNode //////////////////
    pin1Node = FocusNode();
    pin2Node = FocusNode();
    pin3Node = FocusNode();
    pin4Node = FocusNode();
    /////////////// TODO:init Controllers //////////////////
    pin1NodeController = TextEditingController();
    pin2NodeController = TextEditingController();
    pin3NodeController = TextEditingController();
    pin4NodeController = TextEditingController();
  }

  void verifyOtp(String otp, context) {
     Navigator.of(context).pushReplacementNamed(AppPagesNames.CHANGEPASSWORD);
    emit(OtpLoadingState());
    if (formKey.currentState!.validate()) {
     // formKey.currentState!.save();
      String otp = 
          "${pin1NodeController.text}${pin2NodeController.text}${pin3NodeController.text}${pin4NodeController.text}";
      Navigator.of(context).pushReplacementNamed(AppPagesNames.CHANGEPASSWORD);
      // check your code
    } else {
      // TODO:
      //Please Enter OTP message whatever way
    }
  }
}
