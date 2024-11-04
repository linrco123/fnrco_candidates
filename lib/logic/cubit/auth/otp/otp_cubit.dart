import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/data/api_provider/auth/otp.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OTPProvider otpProvider;
  OtpCubit(this.otpProvider) : super(OtpInitial());

  final formKey = GlobalKey<FormState>();
  final List<TextInputFormatter> otpTextInputFormatters = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(1),
  ];
  late final pin1NodeController;
  late final pin2NodeController;
  late final pin3NodeController;
  late final pin4NodeController;
  late final pin5NodeController;
  late final pin6NodeController;
  late FocusNode pin1Node;
  late FocusNode pin2Node;
  late FocusNode pin3Node;
  late FocusNode pin4Node;
  late FocusNode pin5Node;
  late FocusNode pin6Node;

  void initiateFocusNode() {
    ////////////// TODO : init FocusNode //////////////////
    pin1Node = FocusNode();
    pin2Node = FocusNode();
    pin3Node = FocusNode();
    pin4Node = FocusNode();
    pin5Node = FocusNode();
    pin6Node = FocusNode();
    ////////////// TODO : init Controllers //////////////////
    pin1NodeController = TextEditingController();
    pin2NodeController = TextEditingController();
    pin3NodeController = TextEditingController();
    pin4NodeController = TextEditingController();
    pin5NodeController = TextEditingController();
    pin6NodeController = TextEditingController();
  }

  void verifyOtp(context) {
    if (formKey.currentState!.validate()) {
      emit(OtpLoadingState());

      String otp =
          "${pin1NodeController.text}${pin2NodeController.text}${pin3NodeController.text}${pin4NodeController.text}${pin5NodeController.text}${pin6NodeController.text}";
      final Map data = {'provider': CANDIDATE_PROVIDER, 'code': int.parse(otp)};
      otpProvider.verifyOTP(data).then((value) {
        emit(OtpSuccessState());
      }).catchError((error) {
        emit(OtpFailureState(message: error.message));
      });

      // check your code
    }
  }
}
